
local scnvim = require('scnvim')
scnvim.setup()

local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
	extensions = {
		['fzf-sc'] = {
			search_plugin = 'nvi>m-fzf',
			},
		},
	keymaps = {
		[',l'] = map('editor.send_line', {'i', 'n'}),
		[',.'] = {
			map('editor.send_block', {'i', 'n'}),
			map('editor.send_selection', 'x'),
			},
		['<CR>'] = map('postwin.toggle'),
		['<M-CR>'] = map('postwin.toggle', 'i'),
		['zp'] = map('postwin.clear', {'n', 'i'}),
		[',fp'] = map('postwin.focus',{'n'}),
		['<C-k>'] = map('signature.show', {'n', 'i'}),
		['zz'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
		['<leader>st'] = map(scnvim.start),
		['<leader>sp'] = map(scnvim.recompile),
		['<F1>'] = map_expr('s.boot'),
		['<F2>'] = map_expr('s.meter'),
		['zx'] = map_expr('~myFree.()')
		},
	documentation = {
		cmd = '/usr/local/bin/pandoc',
		},
	postwin = {
		float = {
			enabled =true,
			callback =function(id) vim.api.nvim_win_set_option(id, 'winblend', 0) end,
			height =16
			},
		border = {

			}

		},
	snippet = {
		engine ={
		name ="luasnip"
		}
	}
}

scnvim.load_extension('fzf-sc')
