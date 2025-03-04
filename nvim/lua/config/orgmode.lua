require('orgmode').setup({
	org_agenda_files = { '~/orgfiles/*', '~/tank/super/scd/Mandarin/INDEX.org' },
	org_default_notes_file = '~/orgfiles/refile.org',
	org_capture_templates = 
	{ m = {
		description = 'Mandarin',
		template = '**** on ln: %a %?\n %u',
		target = '~/tank/super/scd/Mandarin/INDEX.org'
	} }
})
