local t = require('telescope.builtin')

local function kill()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call("win_findbuf", bufnr)
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
  if modified and #buf_windows == 1 then
    vim.cmd("confirm bdelete")
  else
    vim.cmd("bdelete")
  end
end

vim.keymap.set("n", "<leader>bk", kill, { desc = "[k]ill", silent=true })
vim.keymap.set("n", "<leader>bl",  t.buffers, { desc = "[l]ist"})
vim.keymap.set("n", "<leader>bN", "<Cmd>enew<CR>", { desc = "[N]ew"})
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "[n]ext"})
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "[p]revious"})
vim.keymap.set("n", "<leader>bt", "<Cmd>terminal<CR>", { desc = "[t]erminal"})
