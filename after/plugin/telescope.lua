require('telescope').setup{
	defaults = {
		path_display = { 'truncate' },
		file_ignore_patterns = {
			"maven_build",
			"node_modules",
      "^bazel-",
      "^web/",
		},
	},
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ debounce = 10 }) end, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>f.', function () builtin.find_files({ cwd = require('telescope.utils').buffer_dir() }) end, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
