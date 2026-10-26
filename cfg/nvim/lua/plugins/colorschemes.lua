local plugin = vim.pack.add

plugin({
  { src = "https://github.com/eldritch-theme/eldritch.nvim" },
  { src = "https://github.com/water-sucks/darkrose.nvim" },
})

vim.schedule(function()
  vim.cmd.colorscheme('darkrose')
end)
