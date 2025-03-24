require('orgmode').setup({
	org_agenda_files = { '~/tank/org/*', '~/tank/org_roam_files/' },
	org_default_notes_file = '~/tank/org/refile.org',
	-- org_hide_leading_stars = true,
	org_hide_emphasis_markers = true,
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
