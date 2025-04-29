return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    dir = '~/obsidian-vault',

    vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>', { desc = '[O]pen [N]ew Note' }),
    vim.keymap.set('n', '<leader>ot', ':ObsidianNewFromTemplate<CR>', { desc = '[O]pen from [T]emplate' }),
    vim.keymap.set('n', '<leader>fl', ':ObsidianFollowLink<CR>', { desc = '[F]ollow [L]ink to File' }),

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = 'dailies',
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = '%d%m%Y',
      -- Optional, default tags to add to each new daily note created.
      default_tags = { 'daily' },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = 'daily',

      vim.keymap.set('n', '<leader>mD', ':ObsidianDailies<CR>', { desc = 'Open [D]aily note' }),
    },
    --
    -- -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    -- completion = {
    --   -- Set to false to disable completion.
    --   nvim_cmp = true,
    --   -- Trigger completion at 2 chars.
    --   min_chars = 2,
    -- },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Get the current date and time formatted as DDMMYYYYHHmm
      local timestamp = os.date '%d%m%Y%H%M'

      local suffix = ''
      if title ~= nil then
        -- Transform the title into a valid filename (remove spaces and special characters)
        suffix = '-' .. title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      end

      return timestamp .. suffix
    end,

    wiki_link_func = function(opts)
      return require('obsidian.util').wiki_link_id_prefix(opts)
    end,

    -- Optional, customize how markdown links are formatted.
    markdown_link_func = function(opts)
      return require('obsidian.util').markdown_link(opts)
    end,

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = 'wiki',

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = true,

    -- Optional, for templates (see below).
    templates = {
      folder = 'templates',
      date_format = '%d%m%Y',
      time_format = '%H:%M',
      vim.keymap.set('n', '<leader>mt', ':ObsidianTemplate<CR>', { desc = 'Open [T]emplates' }),
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    sort_by = 'modified',
    sort_reversed = true,

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    search_max_lines = 1000,

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = 'current',
  },
}
