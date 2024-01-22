return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      neogit = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme "catppuccin-mocha"
    local is_mac = vim.fn.has("mac") == 1
    if not is_mac then
        vim.o.guifont = "Iosevka Fixed Medium:h11"
    end
  end
}
