
require('telescope').setup{

  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
    	  ['<C-x>'] = require('telescope.actions').delete_buffer
      }, 
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = require('telescope.actions').which_key,
        ['<C-x>'] = require('telescope.actions').delete_buffer,
		["<CR>"] = require('telescope.actions').select_default
      }
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
require'telescope'.load_extension('scdoc')
require'telescope'.load_extension('supercollider')
-- require'telescope'.load_extension('harpoon')
