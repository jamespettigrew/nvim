require("j.buffers")
require("j.files")
require("j.notes")
require("j.windows")
require("j.workspaces")

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

-- Keeps cursor centred in the screen while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
