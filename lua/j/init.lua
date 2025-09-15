require("j.buffers")
require("j.files")
require("j.notes")
require("j.terminals")
require("j.term-scope").setup()
require("j.windows")
require("j.workspaces").setup()

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.tabstop = 4

-- Keeps cursor centred in the screen while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
