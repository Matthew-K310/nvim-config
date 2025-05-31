-- ~/.config/nvim/lua/theme_switcher.lua

-- Save theme choice in a file for persistence on restart
local theme_file = vim.fn.stdpath 'config' .. '/lua/saved_theme' -- Changed filename to reflect saving name

-- Define the list of colorscheme NAMES you want to cycle through.
-- These are the names you would use with `:colorscheme <name>`.
-- Make sure these names match how the colorschemes are registered by their plugins/files.
local themes = {
  -- Add the *exact names* used with :colorscheme here
  'base16-black-metal-gorgoroth', -- Name used by base16-nvim
  'rose-pine', -- Check your rose-pine setup for the exact name (e.g., 'rose-pine', 'rose-pine-moon')
  'vague', -- Check vague.nvim for the exact name, often 'vague'
  'catppuccin-frappe', -- Check your catppuccin setup for the exact name (e.g., 'catppuccin-mocha')
  -- Add any other colorscheme names you have installed and want to cycle
}

-- Find the initial index based on the loaded theme, or default to 1
local current_theme_index = 1 -- Default to the first theme

-- Function to load the saved colorscheme name from the persistence file
-- Using _G for global access as in your example
_G.load_theme = function()
  local file = io.open(theme_file, 'r')
  if file then
    -- Read the saved colorscheme name
    local saved_theme_name = file:read '*l'
    file:close()

    if saved_theme_name and saved_theme_name ~= '' then -- Check if a name was actually read
      -- Attempt to set the colorscheme using the saved name
      -- Use pcall in case the colorscheme is not available yet (e.g., plugin not loaded)
      local status_ok, err = pcall(vim.cmd.colorscheme, saved_theme_name)
      if not status_ok then
        -- If setting failed, print an error. Neovim might revert to default or builtin.
        print('Failed to load saved colorscheme ' .. saved_theme_name .. ': ' .. err)
        -- Consider adding logic here to set a known default if the saved theme fails.
      else
        -- Find the index of the loaded theme name in our list
        -- This ensures that the toggle cycle starts from the loaded theme
        for i, theme_name in ipairs(themes) do
          if theme_name == saved_theme_name then
            current_theme_index = i
            break
          end
        end
      end
    end
  end
end

-- Function to switch to the next colorscheme in the list
-- Using _G for global access as in your example
_G.switch_theme = function()
  -- Increment index and wrap around
  current_theme_index = (current_theme_index % #themes) + 1

  -- Get the colorscheme name for the next theme
  local next_theme_name = themes[current_theme_index]

  -- Attempt to set the colorscheme
  local status_ok, err = pcall(vim.cmd.colorscheme, next_theme_name)

  if not status_ok then
    print('Failed to set colorscheme ' .. next_theme_name .. ': ' .. err)
    -- Decide how to handle failure. For now, we just print error.
    -- The index will stay, so the next toggle will try the next theme.
  else
    print('Switched to colorscheme: ' .. next_theme_name) -- Optional confirmation

    -- Save the chosen colorscheme name for persistence
    local file = io.open(theme_file, 'w')
    if file then
      file:write(next_theme_name) -- Save only the colorscheme name
      file:close()
    end
  end
end

-- Map the <leader>p key in normal mode to call the switch_theme function
-- Ensure this is in a file that gets sourced by your init.lua
vim.keymap.set('n', '<leader>p', _G.switch_theme, {
  noremap = true, -- Prevent recursive mapping
  silent = true, -- Don't show the command in the command line
  desc = 'Switch Colorscheme', -- Add a description for built-in help
})

-- IMPORTANT: You need to call _G.load_theme() somewhere in your startup process
-- to load the saved theme. With LazyVim, you should call this *after* your
-- plugins are loaded. A common place is at the end of your init.lua or
-- within a VeryLazy hook.
-- Example:
-- vim.api.nvim_create_autocmd("VeryLazy", {
--   callback = function()
--     _G.load_theme()
--   end
-- })
