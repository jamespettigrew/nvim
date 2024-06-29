return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    vim.keymap.set("n", "<leader>gs", "<Cmd>:Neogit kind=vsplit<CR>", { desc = "[S]tatus"})
  end
}
