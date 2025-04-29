-- return { -- 'folke/tokyonight.nvim',
--   'rose-pine/neovim',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   init = function()
--     vim.cmd.colorscheme 'rose-pine'
--
--     vim.cmd.hi 'Comment gui=none'
--   end,
-- }

return {
  {
    'vague2k/vague.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'vague'
    end,
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require('vague').setup {
        -- optional configuration here
      }
    end,
  },
  {
    'RRethy/base16-nvim',
  },
}
