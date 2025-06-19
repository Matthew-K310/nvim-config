return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  event = 'VeryLazy',
  ft = 'markdown',
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    dir = '~/Notes/obsidian-vault',

    vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>', { desc = '[O]pen [N]ew Note' }),
    vim.keymap.set('n', '<leader>ot', ':ObsidianNewFromTemplate<CR>', { desc = '[O]pen from [T]emplate' }),
    vim.keymap.set('n', '<leader>fl', ':ObsidianFollowLink<CR>', { desc = '[F]ollow [L]ink to File' }),

    daily_notes = {
      folder = 'dailies',
      date_format = '%Y%m%d',
      default_tags = { 'daily' },
      template = 'daily',

      vim.keymap.set('n', '<leader>mD', ':ObsidianDailies<CR>', { desc = 'Open [D]aily note' }),
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
        -- Action to only follow link
        ['<leader>ol'] = {
          action = function()
            -- Call the function specifically for following links
            return require('obsidian').util.follow_link()
          end,
          opts = { buffer = true, expr = true },
        },
      },
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Get the current date and time formatted as YYYYmmDDHHMM
      local timestamp = os.date '%Y%m%d%H%M'

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
      date_format = '%Y%m%d',
      time_format = '%H:%M',
      vim.keymap.set('n', '<leader>mt', ':ObsidianTemplate<CR>', { desc = 'Open [T]emplates' }),
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'fzf-lua',
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

    search_max_lines = 1000,

    open_notes_in = 'current',
  },
}
