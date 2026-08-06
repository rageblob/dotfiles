local plugin = vim.pack.add
local map = vim.keymap.set

-- Set timeout for WhichKey responsiveness
vim.opt.timeoutlen = 250

-- DEPENDENCIES
plugin({
  { src = "https://github.com/nvim-lua/popup.nvim" }, -- theme-hub and telescope
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- theme-hub, telescope, lazygit
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- bufferline
})

-- FLASH : fast file navigation
plugin({
  { src = "https://github.com/folke/flash.nvim" },
})
require("flash").setup {}
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" } )
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" } )
map({ "o" }, "r", function() require("flash").remote() end, { desc = "Remote Flash" } )
map({ "x", "o" }, "r", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" } )
map({ "c" }, "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" } )
map({ "n" }, "<leader>ss", function() require("flash").toggle() end, { desc = "Toggle Flash Search" } )

-- TELESCOPE : live-grep powered ui enhancement
plugin({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-media-files.nvim",  },
})
require("telescope").setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      -- find command (defaults to `fd`)
      find_cmd = "rg"
    },
  },
}

-- WHICH-KEY : show available key mappings
plugin({
      { src = "https://github.com/folke/which-key.nvim" },
})
require("which-key").setup {
 triggers = {
   { "<leader>", mode = { "n", "v" } },
 }
}
require("which-key").add {
  {
     {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show available Keybindings (which-key)",
    },
  },
  { "<leader>f", group = "File" }, -- Creating a group makes the menu look organized
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Git-Hunk" },
  { "<leader>n", group = "Line Numbers" },
  { "<leader>l", group = "LSP" },
  { "<leader>p", group = "Plugins" },
  { "<leader>t", group = "Colorschemes" },
  {
    mode = "n",
    { "<leader>wk", "<cmd>WhichKey <cr>", desc = "whichkey all keymaps" },
    { "<leader>wK", function() vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ") end, desc = "whichkey query lookup" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
    { "<leader>fs", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
  },
}

-- COMMENT : better comments
plugin({
  { src = "https://github.com/numToStr/Comment.nvim" },
})
-- optional configuration: https://github.com/numToStr/Comment.nvim#configuration-optional
require("Comment").setup()

-- NVIM-TREE : file explorer
plugin({
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
map({'n', 'v', 'i'}, "<C-n>", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle NvimTree", noremap = true, silent = true })

-- SLIMLINE : prettier status line
plugin({
  { src = "https://github.com/sschleemilch/slimline.nvim" },
})
require("slimline").setup({
  configs = {
    path = {
      hl = {
        primary = 'Label',
      },
    },
    git = {
      hl = {
        primary = 'Function',
      },
    },
    filetype_lsp = {
      hl = {
        primary = 'String',
      },
    },
  },
  style = 'bg',
  bold = true,
  spaces = {
    components = "",
    left = "",
    right = "",
  },
  sep = {
    hide = {
        first = true,
        last = true,
    },
    left = "",
    right = "",
  },
})

-- TAB BAR
-- plugin({
--   { src = 'https://github.com/lewis6991/gitsigns.nvim' },
--   { src = 'https://github.com/romgrk/barbar.nvim' },
-- })
-- require("barbar").setup {
--   -- keymap: https://github.com/romgrk/barbar.nvim#lua
--   auto_hide = 1,
-- }
plugin({
  { src = "https://github.com/akinsho/bufferline.nvim" },
})
require("bufferline").setup{}
map({ "n", "v" }, "<Tab>", "<cmd> BufferLineCycleNext <cr>", { desc = "Next Tab" })
map({ "n", "v" }, "<S-Tab>", "<cmd> BufferLineCyclePrev <cr>", { desc = "Previous Tab" })

-- THEME-HUB : colorscheme picker and manager
plugin({
  { src = "https://github.com/Erl-koenig/theme-hub.nvim" },
})
require("theme-hub").setup({
  install_dir = vim.fn.stdpath("data") .. "/theme-hub",
  auto_install_on_select = true,
  apply_after_install = true,
  persistent = true,
})
map({ "n", "v"}, "<leader>thh", "<cmd> ThemeHub <cr>", { desc = "Pick Colorscheme"})
map({ "n", "v"}, "<leader>thc", "<cmd> ThemeHub clear-persistent <cr>", { desc = "Purge installed colorschemes"})


-- AUTOPAIRS : automatic bracket pairs
plugin({
  { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup {}
-- custom rules for spaces inside pairs
local Rule = require("nvim-autopairs.rule")
require("nvim-autopairs").add_rules({
  -- Add space between parentheses
  Rule(" ", " ")
    :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),

  -- Move right when typing space before closing pair
  Rule("", " )")
    :with_pair(function() return false end)
    :with_move(function(opts) return opts.prev_char:match(".%)") ~= nil end)
    :use_key(" "),

  Rule("", " ]")
    :with_pair(function() return false end)
    :with_move(function(opts) return opts.prev_char:match(".%]") ~= nil end)
    :use_key(" "),

  Rule("", " }")
    :with_pair(function() return false end)
    :with_move(function(opts) return opts.prev_char:match(".%}") ~= nil end)
    :use_key(" "),
})

-- NOICE : EXPERIMENTAL modern ui
-- plugin({
--   { src = 'https://github.com/folke/noice.nvim' }, -- prettier interface
--   { src = 'https://github.com/MunifTanjim/nui.nvim' }, -- prerequisite for noice
-- })
-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--     },
--   },
--   -- you can enable a preset for easier configuration
--   presets = {
--     bottom_search = true, -- use a classic bottom cmdline for search
--     command_palette = true, -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false, -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = false, -- add a border to hover docs and signature help
--   },
--   notify = {
--     enabled = true,
--   },
-- })

-- plugin({
--   { src = 'https://github.com/propet/colorscheme-persist.nvim' },
-- })
-- require('colorscheme-persist').setup {
--   {
--     {
--       "<leader>sc", -- Or your preferred keymap
--       function()
--         require("colorscheme-persist").picker()
--       end,
--       mode = "n",
--       desc = "Choose colorscheme",
--     },
--   },
-- }
