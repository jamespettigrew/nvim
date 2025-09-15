vim.opt.conceallevel = 1

vim.keymap.set("n", "<leader>nn", "<Cmd>Obsidian new<CR>", { desc = "New", silent=true })
vim.keymap.set("n", "<leader>no", "<Cmd>Obsidian quick_switch<CR>", { desc = "Open", silent=true })
vim.keymap.set("n", "<leader>ni", "<Cmd>Obsidian paste_img<CR>", { desc = "Paste Image", silent=true })
vim.keymap.set("n", "<leader>nt", "<Cmd>Obsidian new_from_template<CR>", { desc = "Insert Template", silent=true })
vim.keymap.set("n", "<leader>ns", "<Cmd>Obsidian search<CR>", { desc = "Search", silent=true })
vim.keymap.set("n", "<leader>sn", "<Cmd>Obsidian search<CR>", { desc = "Notes", silent=true })
