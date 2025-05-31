return {
  { -- Main File Manager
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
  },
  { -- Secondary File Manager
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    vim.keymap.set('n', '<leader>n', ':Oil<CR>'),
    -- vim.keymap.set('n', '<leader>n', ':lua require("oil").toggle_float()<CR>'),
    -- vim.keymap.set('n', '<C-n>', ':lua require("oil").toggle_float()<CR>'),
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = {
            'actions.select',
            opts = { vertical = true },
            desc = 'Open the entry in a vertical split',
          },
          ['<C-h>'] = {
            'actions.select',
            opts = { horizontal = true },
            desc = 'Open the entry in a horizontal split',
          },
          ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
          ['<C-p>'] = 'actions.preview',
          ['q'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
        },
        float = {
          padding = 3,
          border = 'rounded',
        },
      }
    end,
  },
}
