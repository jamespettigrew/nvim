return {
  'nanozuki/tabby.nvim',
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local theme = {
      fill = 'TabLineFill',
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }
    vim.o.showtabline = 2 -- Always display tabs, even if only one open
    require('tabby').setup({
      line = function(line)
        local active_workspace_element = {}
        local hl = theme.current_tab or theme.tab

        local active_workspace = require("j.workspaces").active_workspace()
        if active_workspace then
          active_workspace_element = {
            line.sep('', hl, theme.fill),
            active_workspace.title,
            line.sep('', hl, theme.fill),
            margin = ' ',
            hl = hl,
          }
        end

        return {
          {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.fill),
          },
          active_workspace_element,
          hl = theme.fill,
        }
      end,
      -- option = {}, -- setup modules' option,
    })
  end,
}
