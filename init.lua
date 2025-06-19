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

-- Ensure you have your filetype detection setup:
vim.filetype.add {
  extension = {
    templ = 'templ', -- Pattern should be the filetype name
  },
}

-- indicator at 80 characters
vim.opt.colorcolumn = '80'

-- Markdown line limit
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.bo.textwidth = 80
    -- vim.bo.wrap = true
    vim.bo.formatoptions = 't'
  end,
})

-- LaTeX line limit
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'latex',
  callback = function()
    vim.bo.textwidth = 80
    -- vim.bo.wrap = true
    vim.bo.formatoptions = 't'
  end,
})

-- LaTeX compile on write
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex', -- Apply this autocommand only to files ending in .tex
  callback = function()
    local current_file = vim.api.nvim_buf_get_name(0)

    if current_file ~= '' then
      -- Run pdflatex on the current file silently using vim.fn.system()
      -- Note: For complex LaTeX projects, you might need to 'cd' to the
      -- directory first or adjust compiler options.
      vim.fn.system('pdflatex ' .. vim.fn.shellescape(current_file))

      -- Optional: Add a silent notification that compilation finished
      -- vim.notify("pdflatex compilation finished for " .. current_file, vim.log.levels.INFO, { transient = true, timeout = 1000 })
    end
  end,
  desc = 'Run pdflatex on .tex file save', -- Optional description
})

vim.diagnostic.config {
  virtual_text = true,
}

load_theme()
