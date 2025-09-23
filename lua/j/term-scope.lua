local terms = require("toggleterm.terminal")

local M = { }

M.term_cache = { }

function M.on_tab_enter()
  local tab = vim.api.nvim_get_current_tabpage()
  local term_nums = M.term_cache[tab]
  if term_nums then
    for _, k in pairs(term_nums) do
    end
  end
end

function M.on_tab_leave()
  -- print("There were " .. #terms.get_all() .. " unhidden terminals")

  local tab = vim.api.nvim_get_current_tabpage()
  local tab_terms = terms.get_all()
  M.term_cache[tab] = tab_terms
  for _, term in pairs(tab_terms) do
    term.hidden = true
  end

  -- print("Hello! Now there are " .. #terms.get_all() .. " unhidden terminals")
end

function M.setup()
    local group = vim.api.nvim_create_augroup("TermScopeAU", {})
    vim.api.nvim_create_autocmd("TabLeave", { group = group, callback = M.on_tab_leave })
end

return M
