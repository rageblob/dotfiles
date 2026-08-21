-- only GLOBAL keymaps go here.
-- Plugin-specific mappings are defined after loading each plugin.

-- First make Space the <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- quality of life
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save" })
map({ "n", "v" }, "Q", "<cmd> quitall! <cr>", { desc = "Force quit nvim" })
map({ "n", "v" }, "<leader>w", "<cmd> set wrap! <cr>", { desc = "Toggle line wrap", noremap = true, silent = true })
map("n", "<leader>nn", "<cmd> set nu! <CR>", { desc = "toggle line number" })
map("n", "<leader>nr", "<cmd> set rnu! <CR>", { desc = "toggle relative number" })
map({ "n", "v" }, "<leader>rr", "<cmd>source $MYVIMRC <cr>", { desc = "Reload init.lua" })

-- copy and paste
map({ "n", "v" }, "Y", "\"+y", { desc = "Yank selection to system clipboard" })
map({ "n", "v" }, "D", "\"+d", { desc = "Move selection to system clipboard" })
map({ "n", "v" }, "<leader>P", "\"+p", { desc = "Paste from system clipboard" })

-- Comments
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- tab and buffer management
map({"n", "v"}, "<leader>x", "<cmd> bw <cr>", { desc = "Kill active buffer" })
map({"n", "v"}, "<leader><Tab>", "<cmd> bNext <cr>", { desc = "Next buffer" } )
map({"n", "v"}, "<leader><S-Tab>", "<cmd> bprevious <cr>", { desc = "Prevours buffer" } )

-- Movement in Insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Plugin maintenance
map("n", "<leader>pu", "<cmd>lua vim.pack.update()<cr>", { desc = "Update installed plugins" })
-- SPECIAL KEY NAMES
-- <CR>      -- Enter
-- <Tab>     -- Tab
-- <S-Tab>   -- Shift+Tab
-- <Esc>     -- Escape
-- <Space>   -- Space
-- <BS>      -- Backspace
-- <Del>     -- Delete
-- <Up>
-- <Down>
-- <Left>
-- <Right>
