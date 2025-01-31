return {
  'axieax/urlview.nvim',
  vim.keymap.set("n", "\\u", "<Cmd>UrlView<CR>", { desc = "View buffer URLs" }),
  vim.keymap.set("n", "\\U", "<Cmd>UrlView packer<CR>", { desc = "View Packer plugin URLs" }),
}
