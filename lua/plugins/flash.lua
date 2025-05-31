return { -- Faster Finding
  'folke/flash.nvim',
  lazy = 'true',
  opts = {},
  -- stylua: ignore
  keys = {
    { "zk",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  },
}
