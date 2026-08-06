local map = vim.pack.add
local ft = vim.filetype.add

-- PLUGINS
map({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/hiphish/rainbow-delimiters.nvim' },
})

-- SETUP

-- Rainbow-brackets
require('rainbow-delimiters.setup').setup {}

-- Mason
require('mason').setup({
  ui = {
    icons = {
    package_installed = "✓",
    package_pending = "➜",
    }
  }
})
require('mason-lspconfig').setup()
require('mason-tool-installer').setup {
  { 'bash-language-server', auto_update = true },
  { 'gopls', condition = function() return vim.fn.executable('go') == 1 end },
  'terraformls',
}

-- Lspconfig
require('lspconfig/main')

-- Treesitter
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install {
  -- reference : https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md#supported-languages
  'bash', 'c', 'css', 'dockerfile', 'gitcommit', 'gitignore',
  'go', 'helm', 'html', 'java', 'jq', 'jsdoc', 'json', 'kotlin',
  'llvm', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'nginx',
  'nix', 'php', 'phpdoc', 'powershell', 'printf', 'pymanifest', 'python',
  'regex', 'rust', 'ssh_config', 'sql', 'swift', 'terraform', 'toml',
  'typescript', 'vim', 'vimdoc', 'xml', 'yaml',
}
require("nvim-treesitter-textobjects").setup({
	select = {
		enable = true,
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		enable = true,
		set_jumps = true,
	},
})
ft({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

-- SELECT keymaps
local sel = require("nvim-treesitter-textobjects.select")
for _, map in ipairs({
	{ { "x", "o" }, "af", "@function.outer" },
	{ { "x", "o" }, "if", "@function.inner" },
	{ { "x", "o" }, "ac", "@class.outer" },
	{ { "x", "o" }, "ic", "@class.inner" },
	{ { "x", "o" }, "aa", "@parameter.outer" },
	{ { "x", "o" }, "ia", "@parameter.inner" },
	{ { "x", "o" }, "ad", "@comment.outer" },
	{ { "x", "o" }, "as", "@statement.outer" },
}) do
	vim.keymap.set(map[1], map[2], function()
		sel.select_textobject(map[3], "textobjects")
	end, { desc = "Select " .. map[3] })
end

-- MOVE keymaps
local mv = require("nvim-treesitter-textobjects.move")
for _, map in ipairs({
	{ { "n", "x", "o" }, "]m", mv.goto_next_start, "@function.outer" },
	{ { "n", "x", "o" }, "[m", mv.goto_previous_start, "@function.outer" },
	{ { "n", "x", "o" }, "]]", mv.goto_next_start, "@class.outer" },
	{ { "n", "x", "o" }, "[[", mv.goto_previous_start, "@class.outer" },
	{ { "n", "x", "o" }, "]M", mv.goto_next_end, "@function.outer" },
	{ { "n", "x", "o" }, "[M", mv.goto_previous_end, "@function.outer" },
	{ { "n", "x", "o" }, "]o", mv.goto_next_start, { "@loop.inner", "@loop.outer" } },
	{ { "n", "x", "o" }, "[o", mv.goto_previous_start, { "@loop.inner", "@loop.outer" } },
}) do
	local modes, lhs, fn, query = map[1], map[2], map[3], map[4]
	-- build a human-readable desc
	local qstr = (type(query) == "table") and table.concat(query, ",") or query
	vim.keymap.set(modes, lhs, function()
		fn(query, "textobjects")
	end, { desc = "Move to " .. qstr })
end

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})

vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			local success = pcall(function()
				vim.treesitter.start()
			end)
			if not success then
				return
			end
		end
	end,
})
