local M = { }

M._workspaces = { }
M._workspace_history = { }

function M.close_current_workspace()
  local current_workspace = table.remove(M._workspace_history)
  if current_workspace then
    M._workspaces[current_workspace.path] = nil
    vim.cmd.tabclose()

    -- Pop from history stack until we find a workspace that hasn't been closed
    local previous_workspace = nil
    while #M._workspace_history > 0 do
      previous_workspace = table.remove(M._workspace_history)
      if previous_workspace and M._workspaces[previous_workspace.path] then
        M._focus_workspace(previous_workspace.path)
        break
      end
    end
  end
end

function M.switch_workspace()
  local choices = {}
  for _, workspace in pairs(M._workspaces) do
    table.insert(choices, workspace)
  end

  vim.ui.select(choices, {
      prompt = "Workspaces",
      format_item = function(workspace)
          return workspace.title .. " " .. workspace.path
      end,
    }, function(choice)
      if choice then
        M._focus_workspace(choice.path)
      end
  end)

end

function M.open_workspace(title, path)
  if M._workspaces[path] then
    M._focus_workspace(path)
    return
  end

  M._create_workspace(title, path)
end

function M._focus_workspace(path)
  if not M._workspaces[path] then
    return
  end

  local workspace = M._workspaces[path]
  vim.api.nvim_set_current_dir(path)
  vim.api.nvim_set_current_tabpage(workspace.tabpage)
  table.insert(M._workspace_history, workspace)
end

function M._create_workspace(title, path)
  vim.api.nvim_command("$tabnew")
  vim.api.nvim_command("Tabby rename_tab " .. title)
  local tabpage = vim.api.nvim_get_current_tabpage()
  local new_workspace = {
    title = title,
    path = path,
    tabpage = tabpage,
  }
  M._workspaces[path] = new_workspace
  M._focus_workspace(path)

  require("telescope.builtin").find_files{}
end

function M.setup()
  vim.o.showtabline = 2 -- Always display tabs, even if only one open

  vim.keymap.set("n", "<leader><TAB>k", function() M.close_current_workspace() end, { desc = "Close this workspace" })
  vim.keymap.set("n", "<leader><TAB>o",
    function()
      require'telescope'.extensions.project.project{display_type='full'}
    end,
    { desc = "Open project" })
  vim.keymap.set("n", "<leader><TAB><TAB>", function() M.switch_workspace() end, { desc = "Switch workspace"  })
end

return M
