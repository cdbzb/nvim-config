require('orgmode').setup({
	org_agenda_files = { '~/tank/org/*', '~/tank/org_roam_files/*', '~/tank/org_roam_files/daily/*' },
	org_default_notes_file = '~/tank/org/refile.org',
	-- org_hide_leading_stars = true,
	org_hide_emphasis_markers = true,
  org_adapt_indentation = true,
  -- org_special_block_alist = {
  --   SuperCollider = {
  --     indentation = function(block_info)
  --       -- Custom indentation logic for SuperCollider code blocks
  --       return 2  -- 2-space indentation
  --     end
  --   }
  -- },
	org_blank_before_new_entry = { heading = false, plain_list_item = false },
	mappings = {
		org = {
			org_return = nil, -- Disable <CR> mapping
		},
	},
	org_capture_templates = 
	{ 
		m = {
			description = 'Mandarin',
			template = '**** on ln: %a %?\n %u',
			target = '~/tank/super/scd/Mandarin/INDEX.org'
		
		},
		n = {
			description = "Note with line number and filename",
			template = '**** %?\non ln: %a \n %u',
			target = "~/tank/org/org.org",
			headline = 'Refile', -- Prompt for a heading
			datetree = true
		},  },
	})
-- Add this to your Neovim config (e.g., init.lua)
vim.api.nvim_set_keymap('x', 'iS', ':<C-u>normal! [zjV]zk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', 'iS', ':normal viS<CR>', { noremap = true, silent = true })
