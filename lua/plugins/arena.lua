return {
  "dzfrias/arena.nvim",
  event = "BufWinEnter",
  -- Calls `.setup()` automatically
  config = true,
  opts = {
    max_items = 15,
  }
}
