-- BLINK : autocompletion
vim.pack.add({
  { src = 'https://github.com/rafamadriz/friendly-snippets' }, -- prerequisite for blink
  { src = 'https://github.com/L3MON4D3/LuaSnip' }, -- prerequisite for blink
  { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('^1') },
  -- { src = 'https://github.com/saghen/blink.lib' }, -- prerequisite for blink.cmp v2
})

-- require('blink.cmp').build():pwait() -- prerequisite for blink.cmp v2
require('blink.cmp').setup({
  -- reference: https://cmp.saghen.dev/installation#vim-plug
  keymap = {
    preset = 'enter', -- reference: https://cmp.saghen.dev/configuration/keymap.html#enter
    ['<Esc>'] = { 'hide', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = {
    menu = { auto_show = true },
    documentation = { auto_show = true },
    ghost_text = {
      enabled = false,
      show_with_menu = false,
    },
    accept = {
      auto_brackets = {
        enabled = true
      }
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
