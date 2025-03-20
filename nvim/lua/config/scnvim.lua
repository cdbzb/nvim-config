
local scnvim = require('scnvim')
scnvim.setup()
--
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
	ensure_installed = true,
	--[[ sclang = {
		cmd = "/Users/michael/tank/super-mraethel/supercollider/build/Install/SuperCollider/SuperCollider.app/Contents/MacOS/sclang",
	-- 	cmd = "sclang"
		args = {'-l', "/tmp/sclang_conf.yaml"  }
	}, ]]
	extensions = {
		['fzf-sc'] = {
			search_plugin = 'nvim-fzf',
		},
		logger = {
			path = '/tmp/post'
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
		[',sc'] = map('postwin.clear', {'n', 'i'}),
		[',fp'] = map('postwin.focus',{'n'}),
		['<C-k>'] = map('signature.show', {'n', 'i'}),
		['zZ'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
		['<leader>st'] = map('scnvim.start'),
		['<leader>sp'] = map('scnvim.recompile'),
		['<F1>'] = map_expr('s.boot'),
		['<F2>'] = map_expr('s.meter'),
		['zx'] = map_expr('~myFree.()')
		},
	documentation = {
		cmd = '/usr/local/bin/pandoc',
		},
	postwin = {
		size = 55,
		auto_toggle_error = false,
		fixed_size = 55,
		-- highlight = true,
		float = {
			--enabled =true,
			callback =function(id) vim.api.nvim_win_set_option(id, 'winblend', 0) end,
			height = 18
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

-- scnvim.load_extension('fzf-sc')
scnvim.load_extension('logger')
