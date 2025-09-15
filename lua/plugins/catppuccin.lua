return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    integrations = {
      blink_cmp = {
        style = 'bordered',
      },
      neogit = true,
      noice = true,
      notify = true,
      nvimtree = true,
      treesitter = true,
      which_key = true,
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
