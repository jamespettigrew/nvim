return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
      disable_netrw = true,
      hijack_netrw = true,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    vim.keymap.set("n", "<leader>we", "<Cmd>:NvimTreeToggle<CR>", { desc = "Toggle Explorer (nvim-tree)" })

  end,
}
