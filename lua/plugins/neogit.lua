return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    "folke/snacks.nvim", -- optional
  },
  opts = {
    kind = "replace",
    commit_editor = {
      kind = "floating",
      show_staged_diff = true,
      staged_diff_split_kind = "split",
      spell_check = true,
    },
    commit_select_view = {
      kind = "floating",
    },
    commit_view = {
      kind = "floating",
    },
    log_view = {
      kind = "floating",
    },
    rebase_editor = {
      kind = "floating",
    },
    reflog_view = {
      kind = "floating",
    },
    merge_editor = {
      kind = "floating",
    },
    preview_buffer = {
      kind = "floating_console",
    },
    popup = {
      kind = "floating_console",
    },
    stash = {
      kind = "floating_console",
    },
    refs_view = {
      kind = "floating",
    },
    integrations = {
      snacks = true,
    },
  },
  config = function(_, opts)
    require("neogit").setup(opts)

    vim.keymap.set("n", "<leader>gs", "<Cmd>:Neogit kind=vsplit<CR>", { desc = "[S]tatus"})
  end
}
