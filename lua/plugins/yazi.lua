return { -- Main File Manager
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  lazy = 'false',
  hidden = 'true',
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      -- ctrl + n to open
      '<c-n>',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
    yazi_floating_window_border = 'rounded',
    floating_window_scaling_factor = 0.8,
    -- yazi_floating_window_winblend = 20,
  },
}
