require 'vimopts'
require 'mappings'
require 'theme_toggle'

-- local floating_note = require 'floating-note'
-- floating_note.setup {
--   target_file = '~/obsidian-vault/quicknote.md',
-- }

-- vim.o.termguicolors = false
vim.opt.termguicolors = true

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim setup
require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
  },
})

vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

-- indicator at 80 characters
vim.opt.colorcolumn = '81'

-- 80 character line limit, and start new line
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.bo.textwidth = 80 -- Set max line width to 100 characters
    -- vim.bo.wrap = true -- Enable line wrapping
    vim.bo.formatoptions = 't' -- Auto-wrap text when typing
  end,
})

vim.diagnostic.config {
  virtual_text = true,
}

load_theme()
