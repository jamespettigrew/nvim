local M = { }

M._default_path = ""
M._workspaces = { }
M._workspace_history = { }

function M.active_workspace()
  local workspace_id = M._workspace_history[#M._workspace_history]
  return M._workspaces[workspace_id]
end

function M.close_current_workspace()
  local workspace_id = table.remove(M._workspace_history)
  if workspace_id then
    table.remove(M._workspaces, workspace_id)
    vim.cmd.tabclose()
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
        M._focus_workspace(choice)
      end
  end)

end

function M.open_workspace(title, path)
  for _, w in pairs(M._workspaces) do
    if w.title == title then
      M._focus_workspace(w)
      return
    end
  end

  vim.cmd.tabnew()
  local w = M._create_workspace(title, path)
  M._focus_workspace(w)
end

function M._previous_workspace()
  -- Pop from history stack until we find a workspace that hasn't been closed
  while #M._workspace_history > 0 do
    local workspace_id = M._workspace_history[#M._workspace_history]
    if M._workspaces[workspace_id] then
      return M._workspaces[workspace_id]
    end

    table.remove(M._workspace_history)
  end

  return nil
end

function M._focus_workspace(w)
  if w.path ~= "" then
    vim.api.nvim_set_current_dir(w.path)
  else
    vim.api.nvim_set_current_dir(M._default_path)
  end

  vim.api.nvim_set_current_tabpage(w.tabpage)
  table.insert(M._workspace_history, w.id)
end

function M._create_workspace(title, path)
  vim.api.nvim_command("Tabby rename_tab " .. title)
  local tabpage = vim.api.nvim_get_current_tabpage()
  local id = tabpage

  local w = {
    id = id,
    title = title,
    path = path,
    tabpage = tabpage,
  }
  M._workspaces[id] = w
  vim.api.nvim_tabpage_set_var(tabpage, "workspace_id", id)

  return w
end

function M._tab_entered()
  local tabpage = vim.api.nvim_get_current_tabpage()
  local ok, workspace_id = pcall(vim.api.nvim_tabpage_get_var, tabpage, "workspace_id")
  if not ok then
    return
  end

  M._focus_workspace(M._workspaces[workspace_id])
end

function M._tab_closed()
    local tabpages = {}
    for k, tabpage in pairs(vim.api.nvim_list_tabpages()) do
      tabpages[tabpage] = true
    end

    local orphan_workspaces = {}
    for workspace_id, w in pairs(M._workspaces) do
      if not tabpages[w.tabpage] then
        orphan_workspaces[workspace_id] = workspace_id
      end
    end

    for workspace_id in pairs(orphan_workspaces) do
      table.remove(M._workspaces, workspace_id)
    end

    local prev = M._previous_workspace()
    if prev then
      M._focus_workspace(prev)
    end
end

function M.setup()
  M._default_path = vim.fn.getcwd()
  -- Create default workspace
  local default_workspace = M._create_workspace("default", "")
  M._focus_workspace(default_workspace)

  vim.keymap.set("n", "<leader><TAB>k", function() M.close_current_workspace() end, { desc = "Close this workspace" })
  vim.keymap.set("n", "<leader><TAB>o",
    function()
      Snacks.picker.projects({
        dev = { "~/code" },
        recent = false,
        confirm = function(picker, item)
          picker:close()
          if not item then
            return
          end

          local path = item.file
          local split = path:split('/')
          local title = split[#split]
          M.open_workspace(title, path)
          Snacks.picker.git_files()
        end,
        title = "Workspaces",
      })
    end,
    { desc = "Open workspace" })
  vim.keymap.set("n", "<leader><TAB><TAB>", function() M.switch_workspace() end, { desc = "Switch workspace"  })

  vim.api.nvim_create_autocmd("TabEnter", { callback=M._tab_entered})
  vim.api.nvim_create_autocmd("TabClosed", { callback=M._tab_closed})
end

function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find(self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

return M
