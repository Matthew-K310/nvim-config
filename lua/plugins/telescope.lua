return {
  { -- Search for Files
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {

        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        pickers = {
          lsp_document_symbols = {
            theme = 'dropdown',
          },
          lsp_workspace_symbols = {
            theme = 'dropdown',
          },
          live_grep = {
            theme = 'dropdown',
          },
          grep_string = {
            theme = 'dropdown',
          },
          diagnostics = {
            theme = 'dropdown',
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'NONE' })
      -- vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = 'NONE' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files {
          search_dirs = { '.config', 'Developer', 'Documents', 'obsidian-vault', 'Desktop' },
        }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [B]uiltin' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Grep String' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep in Current File' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecent Files' })
      vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = 'Search [D]ocument [S]ymbols' })
      vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, { desc = 'Search [W]orkspace [S]ymbols' })
      vim.keymap.set('n', '<leader>sz', ':Telescope zoxide list<CR>', { desc = '[S]earch [Z]oxide' })
      vim.keymap.set('n', '<leader>sC', builtin.colorscheme, { desc = '[S]et [C]olorscheme' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search Buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>sD', function()
        builtin.find_files { cwd = '~/Developments' }
      end, { desc = '[S]earch [D]ev files' })
      vim.keymap.set('n', '<leader>so', function()
        builtin.find_files { cwd = '~/obsidian-vault' }
      end, { desc = '[S]earch [O]bsidian vault' })
    end,
  },
  {
    'jvgrootveld/telescope-zoxide',
    config = function() end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {
              -- even more opts
            },
          },
        },
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension 'ui-select'
    end,
  },
}
