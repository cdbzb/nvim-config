
wk = require("which-key")
tb = require("telescope.builtin")
tk = require("telekasten")

wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    triggers = {"<leader>","<localleader>"} -- or specify a list manually
  }

wk.register({
	[ "<leader>" ] = {
		f = {
			name = "Find Files",
			n = "notes",
			N = "new note",
			y = "yank link",
			g = {
				name = "grep",
				n = { function() tb.live_grep({cwd='/Users/michael/telekasten/'}) end, "notes" },
				l = { function() tb.live_grep({cwd='/Users/michael/Documents/Logseq'}) end, "LogSeq" },
				c = { function() tb.live_grep({cwd='/Users/michael/tank/super/Extensions/MW-Classes'}) end, "my classes" },
			},
			L = "grep logSeq",
			b = "buffer dir",
			o = { function() tb.oldfiles() end, "telescope recent" },
			t = { function() tb.tags() end, "telescope tags" },

		},
		t= {
			name = "telekasten",
			g = {function() tk.search_notes() end, "search under cursor in notes"},
		},
		z = {
			--name = "fuzzy", -- optional group name
			b = 'buffer',
			r ='recent',
			c = 'current file',
			[ "." ] = 'working dir',
			[ "/" ] = 'root',
			d = 'telescope buffer dir',
			t = { function() tb.find_files() end, "test" },
		}
	}
})
wk.register( {
	["<localleader>"] = {
		name = "SC commands",

		P       = { ":call NowPlayAgain()<CR>","reload and play" },
		p       = {function() require'scnvim'.send("Song.play") end, "play Song" },
		[ "<" ] = "reload part and play",
		[ "," ] = "play Part",
		k       = "recompile",
		l       = "send line/selection",
		u       = "play this tune",
		["."]   = "send block",
		d = {
			name = "synthDefs",
			c = "controls",
			t = "tree",
			f = "find",
			p = "play"
		},
		c = {
			name = "cursor",
			u = "input",
			h = "Here",
			H = "set Here and Play Song"
		},
		s = {
			name = "sclang",
			t = "start",
			p = "stop",
			c = "clear Post",
			d = "send to sclang"
		},
		i = {
			name = "ii for part under cursor",
			i = "play part under cursor"
		},
		r = {
			e = { ":call RecordSection()<CR>", "record section" }
		},
}} )

vim.cmd( [[

nmap <leader>fzb :CtrlPBuffer<CR>
nmap <leader>fzc :CtrlPCurFile<CR>
nmap <leader>fz/ :CtrlPRoot<CR>
nmap <leader>fz. :CtrlPCurWD<CR>
nmap <leader>fzr :CtrlPMRU<CR>


nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
nnoremap <leader>zC :CalendarT<CR>
nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
nnoremap <leader>za :lua require('telekasten').show_tags()<CR>
nnoremap <leader># :lua require('telekasten').show_tags()<CR>
nnoremap <leader>zr :lua require('telekasten').rename_note()<CR>


nnoremap <leader>fzd :lua require'telescope.builtin'.find_files({cwd = vim.fn.expand("%:p:h")}) <CR>
nnoremap <leader>fzs :lua require'telescope.builtin'.find_files({cwd='/Users/michael/tank/super/'}) <CR>


nmap <localleader>dp yaw :call v:lua.require'scnvim'.send("")<left><left>Synth( \\<C-R>" )<CR>
nmap <localleader>ii yaw:call v:lua.require'scnvim'.send("Song.current.<C-r>".play")<CR>
map <localleader>, :call v:lua.require'scnvim'.send("Part.play")<CR>
nmap <localleader>sd :call v:lua.require'scnvim'.send("")<left><Left>
nmap <localleader>st :SCNvimStart<CR>
nmap <localleader>sp :SCNvimStop<CR>
nmap <localleader>k <ESC>:w<ENTER>:SCNvimRecompile<ENTER>
nmap <localleader>x :call v:lua.require'scnvim'.send("~myFree.()")<CR>
nmap zx :call v:lua.require'scnvim'.send("~myFree.()")<CR>
nmap <localleader>z <Plug>(scnvim-hard-stop)
nmap zz <Plug>(scnvim-hard-stop)
nmap <localleader>. <Plug>(scnvim-send-block)
nmap <localleader>l <Plug>(scnvim-send-line)
vmap <localleader>l <Plug>(scnvim-send-selection)
nmap <localleader>sc <Plug>(scnvim-postwindow-clear)
map <localleader>rpp m`ggl"zy$:!tmux new -d "open -a REAPER64.app <C-r>z"<CR>``
nnoremap <localleader>df :silent execute "grep! -r SynthDef.*" . shellescape(expand("<cword>")) . " ~/tank/super/SynthDefLibrary/*"<cr>:copen<cr>
nnoremap <localleader>dc yaw :call v:lua.require'scnvim'.send("")<left><Left>SynthDescLib.at(  \\<C-r>"  ).dump<cr>
nnoremap <localleader>dt     :call v:lua.require'scnvim'.send("")<left><Left>SynthDefLibrary.tree<cr>
map <localleader>u $F"vF"c
nmap <localleader>< m`:call SelectPart()<CR>,.<ESC>,,``
"cursor
nmap <localleader>cu :call SetCursor()<CR>
nmap <localleader>ch :call PlayFromHere()<CR>
nmap <localleader>cH :call PlayFromHere()<CR>,p
nmap <localleader>or :call v:lua.require'scnvim'.send("Part.current.rpp.open")<CR>
]] )

