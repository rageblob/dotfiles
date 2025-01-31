return {
  'alexghergh/nvim-tmux-navigation',
  lazy = false,
  priority = 1000,
  config = function()
    require('nvim-tmux-navigation').setup({})
    vim.keymap.set({'n','v'}, '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', {})
    vim.keymap.set({'n','v'}, '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', {})
    vim.keymap.set({'n','v'}, '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', {})
    vim.keymap.set({'n','v'}, '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', {})
  end
}
