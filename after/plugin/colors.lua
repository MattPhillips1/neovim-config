function Color(color)
  local colorscheme = color or "rose-pine-main"
  if colorscheme == "dark" then
    colorscheme = "rose-pine-main"
  elseif color == "light" then
    colorscheme = "rose-pine-dawn"
  end
	vim.cmd.colorscheme(colorscheme)
end

Color()
