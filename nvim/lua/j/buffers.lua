local t = require('telescope.builtin')

vim.keymap.set("n", "<leader>bk", "<Cmd>bdelete<CR>", { desc = "[k]ill"})
vim.keymap.set("n", "<leader>bl",  t.buffers, { desc = "[l]ist"})
vim.keymap.set("n", "<leader>bN", "<Cmd>enew<CR>", { desc = "[N]ew"})
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "[n]ext"})
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "[p]revious"})
vim.keymap.set("n", "<leader>bt", "<Cmd>terminal<CR>", { desc = "[t]erminal"})
