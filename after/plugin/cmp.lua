local cmp = require('blink.cmp')
cmp.build():wait(300000)
cmp.setup({
   keymap = {
    preset = 'enter',
  }
})
