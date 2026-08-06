local plugin = vim.pack.add
local map = vim.keymap.set

plugin({
  { src = 'https://github.com/kdheepak/lazygit.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/ruifm/gitlinker.nvim' },
})

-- LAZYGIT
map('n', '<leader>gl', '<cmd>LazyGit<cr>', { desc = "LazyGit" })
map('n', '<leader>L', '<cmd>LazyGit<cr>', { desc = "LazyGit" })

-- GITSIGNS
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<A-Right>', function()
      if vim.wo.diff then
        vim.cmd.normal({'<A-Right>', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '<A-Left>', function()
      if vim.wo.diff then
        vim.cmd.normal({'<A-Left>', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Git: Stage Hunk" })
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- toggles
    map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = "Git: Toggle line blame" })
    map('n', '<leader>gw', gitsigns.toggle_word_diff, { desc = "Git: Toggle word diff" })

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}

-- GITLINKER
require("gitlinker").setup({
  callbacks = {
    ["gitlab%..*%.sh"] = require("gitlinker.hosts").get_gitlab_type_url,
  },
})
map('n', '<leader>gO', function() require('gitlinker').get_buf_range_url('n', { action_callback = require('gitlinker.actions').open_in_browser }) end, { desc = 'Open current line in Browser' })
map('v', '<leader>gO', function() require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser }) end, { desc = 'Open current line in Browser' })
map({'n', 'v'}, '<leader>gR', '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>', { desc = "Open repo in Browser" })

-- Additional mappings
map({"n", "v"}, "<leader>ld", "<cmd>Telescope diagnostics <cr>", { desc = "Show LSP diagnostics" })
