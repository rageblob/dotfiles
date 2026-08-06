-- Global nvim settings
-- reference: https://neovim.io/doc/user/quickref/#option-list
local o = vim.opt
o.number = true -- line numbers
o.relativenumber = true
o.expandtab = true -- use spaces when <Tab> is inserted
o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
o.tabstop = 2 -- number of columns between two tab stops
o.breakindent = true
o.preserveindent = true
o.fillchars = { eob = " " } -- https://neovim.io/doc/user/options/#'fillchars'
o.termguicolors = true
