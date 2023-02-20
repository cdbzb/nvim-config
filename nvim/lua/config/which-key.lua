
wk = require("which-key")
tb = require("telescope.builtin")
utils = require("telescope.utils")
tk = require("telekasten")
sc = require("scnvim")


wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    triggers = {"<leader>","<localleader>"} -- or specify a list manually
  }

wk.register({
	s = { "<Plug>Lightspeed_s", "lightspeed" };
	[ "<leader>" ] = {
		b = { 
			name = "buffers",
			e = { ":call DeleteEmptyBuffers()<CR>", "delete empty" },
			b = { ":source /Users/michael/.config/nvim/lua/config/bufferline.lua","source bufferline.lua"},
		},
		f = {
			name = "Find Files",
			n = { function() tk.find_notes() end, "Notes" },
			N = {function() tk.new_note() end, "New Note" },
			D = {function() tk.find_daily_notes() end,"Dailys" },
			d = {function() tk.goto_today() end, "Today (home)" },
			y = {function() tk.yank_notelink() end, "yank link"},

			s = { function() tb.find_files({ cwd='/Users/michael/tank/super/More-Organized-Trek/Songs/' }) end, "Songs" },
			g = {
				name = "grep",
				n = { function() tb.live_grep({cwd='/Users/michael/telekasten/'}) end,                      "notes" },
				l = { function() tb.live_grep({cwd='/Users/michael/Documents/Logseq'}) end,                 "LogSeq" },
				c = { function() tb.live_grep({cwd='/Users/michael/tank/super/Extensions/MW-Classes'}) end, "my classes" },
				h = { function() tb.live_grep() end, "here" },

			},
			b = "buffer dir",
			o = { function() tb.oldfiles() end,                                                "Recent" },
			t = { function() tb.tags() end,                                                    "Tags" },
			c = { function() tb.find_files({ cwd='~/tank/super/Extensions/MW-Classes/' }) end, "My Classes" },
			h = { function() tb.find_files({ cwd=utils.buffer_dir() }) end,                    "Here" },
			b = { function() tb.buffers() end,                                                 "Buffers" },
			k=  {
				name = "telekasten",
				--	= {function() tk.new_note() end, "New" },
				--	= {function() tk.new_templated_note() end, },
				t      = {function() tk.show_tags() end, "Show Tags" },
				y       = {function() tk.yank_notelink() end, "Yank" },
				c       = {function() tk.show_calendar() end, "Calendar" },
				k       = { function() tk.follow_link() end, "follow link" },
				K       = { function() tk.insert_link() end, "insert link" },
				--	= {function() tk.paste_img_and_link() end, },
				--	= {function() tk.toggle_todo() end, },
				--	= {function() tk.show_backlinks() end, },
				--	= {function() tk.find_friends() end, },
				--	= {function() tk.preview_img() end, },
				--	= {function() tk.browse_media() end, },
				--	= {function() tk.show_tags() end, },
				--	= {function() tk.rename_note() end, },
				g = {function() tk.search_notes() end, "search under cursor in notes"},
			},

		},
		pf = {function() sc.send("PF()") end, "make a piano!"},
		z = {
			--name = "fuzzy", -- optional group name
			b       = 'buffer',
			r       = 'recent',
			c       = 'current file',
			[ "." ] = 'working dir',
			[ "/" ] = 'root',
			d       = 'telescope buffer dir',
			t       = { function() tb.find_files() end, "test" },
		},
		w = {
			name = "Window",
			o = { ":only<cr>","only" },
			j = { "<C-w>j","next" },
			k = { "<C-w>k","previous" },
			h = { "<C-w>h","left" },
			l = { "<C-w>l","right" },
			c = { "<C-w>c","close" },
		},
		a = {function() sc.send("Date.insertStamp") end, "Insert Timestamp"},
		t = { name = terminal,
			t = { ":ToggleTerm<CR>","ToggleTerm"  }

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
		--o       = "open RPP",
		f       = { ":set ft=supercollider<CR>","set filetype" },
		k       = "recompile",
		l       = "send line/selection",
		u       = "play this tune",
		n       = {function() require'scnvim'.send("Song.playOnly()") end, "play Only Again"},
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
			e = { ":call RecordSection()<CR>", "record section" },
			o = { function() sc.send("Part.current.rpp.open") end, "open RPP" },
			b = { function() sc.send("Part.current.rpp.build") end, "build RPP" }
		},
		v = { 
			o = { function() sc.send("Part.current.synthV.open") end, "open synthV" },
			r = { function() 
				vim.api.nvim_call_function("SelectPart",{})
				-- vim.api.nvim_call_function("sleep",{0.1})
				require'scnvim.editor'.send_selection()
				sc.send("Part.current.synthV.render")
			end, "render synthV" }
		},
		a = { 
			name = "arm",
			o = {function() sc.send("RecOnsets.record") end, "RecOnsets"},
			k = {function() sc.send("RecKey.record") end, "RecKey"},
			e = {function() sc.send("RecEnv.record") end, "RecEnv"},
			r = {function() sc.send("Rec.record") end, "Rec"}


		}
}} )

vim.cmd( [[

nmap zm :Limelight<cr>
nmap zM :Limelight!<cr>
nmap <leader>fzb :CtrlPBuffer<CR>
nmap <leader>fzc :CtrlPCurFile<CR>
nmap <leader>fz/ :CtrlPRoot<CR>
nmap <leader>fz. :CtrlPCurWD<CR>
nmap <leader>fzr :CtrlPMRU<CR>


nnoremap <leader>zC :CalendarT<CR>
nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>

" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> '<Plug>expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.

inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

inoremap <silent> <C-]> <cmd>lua require'luasnip'.jump(1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

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
]] )

