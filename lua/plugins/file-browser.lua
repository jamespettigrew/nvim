return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function(_, opts)
    require("telescope").load_extension "file_browser"
    vim.keymap.set("n", "<leader>ff", "<Cmd>:Telescope file_browser path=%:p:h<CR>", { desc = "Browse" })
  end
}
