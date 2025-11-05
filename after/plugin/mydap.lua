local SIGN_TEXT = "B"
local breakpoints = {}
local jdb_job = nil;
local navigation_win = nil;
local curr_breakpoint = nil;

local ns  = vim.api.nvim_create_namespace('mydap')

local function goto_location(filename, line_number)
  local bufnr = vim.fn.bufnr(filename)

  if bufnr == -1 then
    bufnr = vim.fn.bufadd(filename)
    vim.fn.bufload(bufnr)
  end

  vim.api.nvim_win_set_buf(navigation_win, bufnr)
  vim.api.nvim_win_set_cursor(navigation_win, {line_number, 0})
  vim.api.nvim_win_call(navigation_win, function()
    vim.cmd('normal! zz')
  end)
  return bufnr
end

local function parse_breakpoint(line)
    local thread = line:match('thread=([^"]+)"')
    local class_name = line:match('(%S+)%.[^%.]+%(%)') -- Everything before the last method
    local line_number = line:match('line=(%d+)')

    return {
        thread = thread,
        class_name = class_name,
        line_number = tonumber(line_number)
    }
end

local function create_line_buffered_handler(process_line)
  local buffer = ""

  return function(_, data, _)
    if not data then return end

    for _, chunk in ipairs(data) do
      buffer = buffer .. chunk
      while true do
        local newline_pos = buffer:find("\n")
        if not newline_pos then
          newline_pos = buffer:find("\r")
        end
        if not newline_pos then break end

        local line = buffer:sub(1, newline_pos - 1)
        buffer = buffer:sub(newline_pos + 1)

        process_line(line)
      end
    end

    -- Handle EOF: process any remaining buffered content
    if data[#data] == "" then
      if buffer ~= "" then
        process_line(buffer)
        buffer = ""
      end
    end
  end
end

local function processstdout(line)
  if line == "" then
    return
  end
  if line:match("^Breakpoint hit:.*") then
    local b = parse_breakpoint(line)
    local debugger_loc = b.class_name .. ":" .. b.line_number
    if breakpoints[debugger_loc] ~= nil then
      if curr_breakpoint ~= nil then
        vim.api.nvim_buf_set_extmark(curr_breakpoint.buf, ns, curr_breakpoint.line_number, 0, { id = curr_breakpoint.mark, sign_text = SIGN_TEXT })
        curr_breakpoint = nil
      end
      local breakpoint = breakpoints[debugger_loc];
      local file_path = breakpoint.file_loc
      local colon_loc = file_path:find(":", 1, true);
      local file_name = file_path:sub(1, colon_loc - 1);
      local buf = goto_location(file_name, b.line_number)
      curr_breakpoint = { mark = breakpoint.mark, line_number = b.line_number - 1, buf = buf}
      vim.api.nvim_buf_set_extmark(buf, ns, b.line_number-1, 0, { id = breakpoint.mark, sign_text = '->' })
    end
  end
end

local function tojavalocation(k)
  local matches = {}
  for part in string.gmatch(k, "[^:]+") do
    table.insert(matches, part)
  end
  assert(#matches == 2)
  local filename = matches[1]
  local linenum = matches[2]
  local packagefilename = ""
  if string.match(filename, "src/main/java/") then
    packagefilename = string.gsub(filename, ".*src/main/java/", "")
  elseif string.match(filename, "src/test/java/") then
    packagefilename = string.gsub(filename, ".*src/test/java/", "")
  end
  local withoutfilename = string.gsub(packagefilename, ".java$", "")
  local packageandclass = string.gsub(withoutfilename, "/", ".")
  return packageandclass .. ":" .. linenum
end

local function togglebreakpoint()
  local path = vim.api.nvim_buf_get_name(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local linenum = cursor[1]
  local loc = path ..":".. linenum
  local javalocation = tojavalocation(loc)
  local existing_breakpoint = breakpoints[javalocation]
  if not existing_breakpoint then
    if jdb_job ~= nil then
      vim.fn.chansend(jdb_job, "stop at" .. javalocation .. "\n")
    end
    local mark = vim.api.nvim_buf_set_extmark(0, ns, linenum-1, 0, { sign_text = SIGN_TEXT })
    breakpoints[javalocation] = { mark = mark, file_loc = loc };
  else
    if jdb_job ~= nil then
      vim.fn.chansend(jdb_job, "clear " .. javalocation .. "\n")
    end
    vim.api.nvim_buf_del_extmark(0, ns, existing_breakpoint.mark)
    breakpoints[javalocation] = nil
  end
end

local function clearbreakpoints()
  for k, v in pairs(breakpoints) do
    vim.api.nvim_buf_del_extmark(0, ns, breakpoints[k].mark)
    breakpoints[k] = nil
  end
    if jdb_job ~= nil then
      vim.fn.chansend(jdb_job, "clear\n")
    end
end

local function startjdb()
  navigation_win = vim.api.nvim_open_win(0, true, {split = 'below'})
  local buf = vim.api.nvim_create_buf(true, true)
  local jdb_window = vim.api.nvim_open_win(buf, true, {
    split = 'left',  -- or 'above', 'left', 'right'
  })
  jdb_job = vim.api.nvim_buf_call(buf, function()
    return vim.fn.jobstart(
      {'jdb', '-attach', 'localhost:5005'},
      {
          on_stdout = create_line_buffered_handler(processstdout),
          on_stderr = function(job_id, exit_code, event) end,
          on_exit = function(job_id, exit_code, event)
            if curr_breakpoint ~= nil then
              vim.api.nvim_buf_set_extmark(curr_breakpoint.buf, ns, curr_breakpoint.line_number, 0, { id = curr_breakpoint.mark, sign_text = SIGN_TEXT })
              curr_breakpoint = nil
            end
            if navigation_win ~= nil then
              vim.api.nvim_win_close(navigation_win, false)
              navigation_win = nil
            end
            jdb_job = nil
          end,
          stdout_buffered = false,
          stderr_buffered = false,
          term = true,
      }
  )
  end)


  for k, v in pairs(breakpoints) do
    vim.fn.chansend(jdb_job, "stop at " .. k .. "\n")
  end 
end

vim.keymap.set('n', '<leader>db', togglebreakpoint)
vim.keymap.set('n', '<leader>dc', clearbreakpoints)
vim.keymap.set('n', '<leader>dr', startjdb)
