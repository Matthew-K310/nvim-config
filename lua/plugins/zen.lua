return {
  'folke/zen-mode.nvim',
  opts = {},
  config = function()
    require('zen-mode').setup {
      window = {
        -- width = 85,
        width = 100,
        -- transparent = true,
      },
    }
    vim.keymap.set('n', '<leader>zz', ':ZenMode<CR>')
  end,
}
