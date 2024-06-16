vim.opt.conceallevel = 1

vim.keymap.set("n", "<leader>nn", "<Cmd>ObsidianNew<CR>", { desc = "New", silent=true })
vim.keymap.set("n", "<leader>no", "<Cmd>ObsidianQuickSwitch<CR>", { desc = "Open", silent=true })
vim.keymap.set("n", "<leader>ni", "<Cmd>ObsidianPasteImg<CR>", { desc = "Paste Image", silent=true })
vim.keymap.set("n", "<leader>nt", "<Cmd>ObsidianTemplate<CR>", { desc = "Insert Template", silent=true })
vim.keymap.set("n", "<leader>ns", "<Cmd>ObsidianSearch<CR>", { desc = "Search", silent=true })
