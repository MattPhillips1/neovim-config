require('gitsigns').setup({
  watch_gitdir = {
    -- Disable because watchman (https://facebook.github.io/watchman) updates the .git directory often
    -- when using it as git.fsmonitor
    enable = false,
  },
})
