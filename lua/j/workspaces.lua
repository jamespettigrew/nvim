vim.o.showtabline = 2 -- Always show workspaces, even if only one open

vim.api.nvim_set_keymap("n", "<leader><TAB>k", ":tabclose<CR>", { desc = "Kill" })
vim.keymap.set("n", "<leader><TAB>o",
  function()
    require'telescope'.extensions.project.project{display_type='full'}
  end,
  { desc = "Open Project" })
vim.api.nvim_set_keymap("n", "<leader><TAB>n", ":tabn<CR>", { desc = "Next"  })
vim.api.nvim_set_keymap("n", "<leader><TAB>p", ":tabp<CR>", { desc = "Previous" })
