return {
  {
    'RRethy/base16-nvim',
    lazy = false,
    config = function()
      vim.cmd 'silent! colorscheme base16-black-metal-gorgoroth'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine', -- Set a name
    lazy = true,
    config = function()
      require('rose-pine').setup {
        variant = 'moon', -- "main", "moon" or "dawn"
        transparent_background = true,
      }
    end,
  },
  {
    'https://github.com/vague2k/vague.nvim', -- Assuming this is the correct repo
    name = 'vague', -- Set a name
    lazy = true,
    transparent_background = true,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin', -- Set a name for the plugin
    lazy = true,
    config = function()
      require('catppuccin').setup {
        -- your configuration, for example...
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        transparent_background = true,
        default_integrations = true,
        integrations = {
          harpoon = true,
        },
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    DEFAULT_OPTIONS = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      mode = 'background', -- Set the display mode.
    },
  },
}
