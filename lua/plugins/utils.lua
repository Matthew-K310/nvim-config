return {
  { -- Autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function}
  },

  { -- Faster Finding
    'folke/flash.nvim',
    lazy = 'true',
    opts = {},
    keys = {
      {
        'zk',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
    },
  },
  { -- Git helper
    'tpope/vim-fugitive',
  },
  { -- Tmux navigation
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  { -- Transparency
    'xiyaowong/transparent.nvim',
    vim.keymap.set('n', '<leader>te', ':TransparentToggle<CR>'),
  },
  { -- Undotree
    'mbbill/undotree',
  },
  { -- Zen mode
    'folke/zen-mode.nvim',
    opts = {},
    config = function()
      require('zen-mode').setup {
        window = {
          -- width = 85,
          width = 100,
          transparent = true,
        },
      }
      vim.keymap.set('n', '<leader>zz', ':ZenMode<CR>')
    end,
  },
}
