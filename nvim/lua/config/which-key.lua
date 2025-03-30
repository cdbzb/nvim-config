
wk = require("which-key")
tb = require("telescope.builtin")
utils = require("telescope.utils")
-- tk = require("telekasten")
sc = require("scnvim")

wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    -- triggers = {"<leader>","<localleader>",} -- or specify a list manually
       triggers = {
		   {" "},
		   {","},
         -- { "<auto>", mode = "nixsotc" },
         { "<auto>", mode = "nxsotc" },
         { "a", mode = { "n", "v" } },
       }
  }

wk.register({

	-- s = { "<Plug>Lightspeed_s", "lightspeed" };
	[ "<leader>" ] = {
		j = {
			name = jump,
			l = {
				"/GaddLine<enter>z.","nextline" 
			}
		},
		b = { 
			name = "buffers",
			e = { ":call DeleteEmptyBuffers()<CR>", "delete empty" },
			b = { ":source /Users/michael/.config/nvim/lua/config/bufferline.lua","source bufferline.lua"},
			w = { ":lua MiniBufremove.wipeout()<CR>", "miniBuf Wipeout" },
			d = { ":lua MiniBufremove.wipeout()<CR>", "miniBuf Delete" },
			U = { ":lua MiniBufremove.unshow()<CR>", "miniBuf Unshow All" },
			u = { ":lua MiniBufremove.unshow_in_window()<CR>", "miniBuf Unshow in Win" },

		},
		e = {
			name = "edit",
			c = { ":e ~/.config/nvim/lua <CR>", "nvim lua config" },
			w = { ":e ~/.config/nvim/lua/config/which-key.lua <CR>", "which-key config" }
		},
		f = {
			name = "Find Files",
			d = {function() require'telescope'.extensions.supercollider.sc_definitions() end, "sc defs"},
			D = {function() require'telescope'.extensions.scdoc.scdoc() end, "sc docs" },
			s = { function() tb.find_files({ cwd='/Users/michael/tank/super/Trek/Songs/' }) end, "Songs" },
			c = { function() tb.find_files({ cwd='/Users/michael.config' }) end, "config" },
			g = {
				name = "grep",
				-- n = { function() tb.live_grep({cwd='/Users/michael/telekasten/'}) end,                      "notes" },
				l = { function() tb.live_grep({cwd='/Users/michael/Documents/Logseq'}) end, "LogSeq" },
				o = { function() require'telescope'.extensions.orgmode.search_headings() end, "org" },
				s = { function() tb.live_grep({cwd='/Users/michael/tank/super/Trek/Songs'}) end, "Songs" },
				k = { function() tb.live_grep({cwd='/Users/michael/tank/super/Trek'}) end, "Trek" },
				c = { function() tb.live_grep({cwd='/Users/michael/tank/super/Trek/MW-Classes'}) end, "my classes" },
				h = { function() tb.live_grep() end, "here" },

			},
			b = "buffer dir",
			o = { function() tb.oldfiles() end,                                                "Recent" },
			t = { function() tb.tags() end,                                                    "Tags" },
			c = { function() tb.find_files({ cwd='~/tank/super/Trek/MW-Classes/' }) end, "My Classes" },
			h = { function() tb.find_files({ cwd=utils.buffer_dir() }) end,                    "Here" },
			b = { function() tb.buffers() end,                                                 "Buffers" },
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
		t = {
			name = "terminal",
			t = { ":ToggleTerm<CR>","ToggleTerm"  }
		},
		l = {
			name = "launch",
			g = { ":Neogit<CR>","NeoGit"},
		},
		n = {
			P = { ":!~/.config/nvim/scripts/push-org.sh<CR>", "push org-roam"}
		}

	}
})

wk.register( {
	["<localleader>"] = {
		name = "SC commands",

		P       = { ":call NowPlayAgain()<CR>","reload and play" },
		p       = {function() require'scnvim'.send("Song.play") end, "play Song" },
		o		= {function() require'scnvim'.send("Song.makeScroll") end, "makeScroll"},
		[ "<" ] = "reload part and play",
		[ "," ] = "play Part",
		--o       = "open RPP",
		f       = { ":set ft=supercollider<CR>","set filetype" },
		k       = "recompile",
		l       = "send line/selection",
		m = {
			name = "monitors",
			f = {function() sc.send("Monitors.gui") end, "volume fader"},
			m = {function() sc.send("s.volume_(-90); Monitors.gui") end, "volume fader"},
			a = {function() require'scnvim'.send("Monitors.airpods") end, "airpods"},
			b = {function() require'scnvim'.send("Monitors.bose") end, "airpods"},
			h = {function() require'scnvim'.send("Monitors.headphones") end, "headphones"},
			z = {function() require'scnvim'.send("Monitors.zoom") end, "zoom"},
			t = {function() require'scnvim'.send("().play") end, "test"}
		},
		u       = "play this tune",
		n       = {function() require'scnvim'.send("Song.playOnly()") end, "play Only Again"},
		N       = { [[:call v:lua.require'scnvim'.send("Song.playOnly(\\)")<LEFT><LEFT><LEFT>]],"play only"  },
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
			H = "set Here and Play Song",
			d = {function() require'scnvim'.send("Song.cursor_(Song.cursor - 1)") end, "decrement"}
		},
		s = {
			name = "sclang",
			t = "start",
			p = "stop",
			c = {function() require'scnvim.postwin'.clear() end, "clear Post" },
			d = "send to sclang",
			b = {function() sc.send("s.newBusAllocators") end, "new BusAllocators"},
			m = {function() sc.send("Song.makeScroll") end, "Make Song Scroll"},
			f = {function() sc.send("PF()") end, "make a piano!"},
			s = {function() sc.send("s.boot") end, "boot server"},
		},
		[ "/" ] = {
				function()
				vim.api.nvim_call_function("SelectPart",{})
				-- vim.api.nvim_call_function("sleep",{0.1})
				require'scnvim.editor'.send_selection()
			end, "reload part without playing"
			},
		i = {
			name = "ii for part name under cursor",
			i = "play part under cursor"
		},
		r = {
			name = "record section - RPP",
			e = { ":call RecordSection()<CR>", "record section" },
			o = { function() sc.send("Part.current.rpp.open") end, "open RPP" },
			b = { function() sc.send("Part.current.rpp.build") end, "build RPP" }
		},
		v = {
			name = "synthVs",
			o = { function() sc.send("Part.current.synthV.open") end, "open synthV" },
			r = {
				function() 
					vim.api.nvim_call_function("SelectPart",{})
					-- vim.api.nvim_call_function("sleep",{0.1})
					require'scnvim.editor'.send_selection()
					sc.send("Part.current.synthV.render")
				end, "render synthV" 
			},
			R = { function() 
				vim.api.nvim_call_function("SelectPart",{})
				-- vim.api.nvim_call_function("sleep",{0.1})
				require'scnvim.editor'.send_selection()
				sc.send("SynthV.renderMultiple")
			end, "render synthVs" },
			s = { function ()
				vim.api.nvim_call_function("PlayFromHere",{})
				sc.send("SynthV.renderSection")
			end, "render SynthVs in section"
			}
		},
		a = { 
			name = "arm",
			o = {function() sc.send("RecOnsets.record") end, "RecOnsets"},
			k = {function() sc.send("RecKey.record") end, "RecKey"},
			e = {function() sc.send("RecEnv.record") end, "RecEnv"},
			r = {function() sc.send("Rec.record") end, "Rec"}
		},
		w = {
			name = "Window",
			c = {function() sc.send("Window.closeAll") end, "closeAll"}
		}
	}
})

vim.cmd( [[

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
nmap zx :call v:lua.require'scnvim'.send("MyFree()")<CR>
nmap zz :call v:lua.require'scnvim'.send("MyFree()")<CR>
nmap <localleader>z <Plug>(scnvim-hard-stop)
nmap zZ <Plug>(scnvim-hard-stop)
" nmap <localleader>. <Plug>(scnvim-send-block)
nmap <localleader>l <Plug>(scnvim-send-line)
vmap <localleader>l <Plug>(scnvim-send-selection)
" nmap <localleader>sc <Plug>(scnvim-postwindow-clear)

map <localleader>rpp m`ggl"zy$:!tmux new -d "open -a REAPER64.app <C-r>z"<CR>``
nnoremap <localleader>df :silent execute "grep! -r SynthDef.*" . shellescape(expand("<cword>")) . " ~/tank/super/Trek/SynthDefLibrary/*"<cr>:copen<cr>
nnoremap <localleader>dc yaw :call v:lua.require'scnvim'.send("")<left><Left>SynthDescLib.at(  \\<C-r>"  ).dump<cr>
nnoremap <localleader>dt     :call v:lua.require'scnvim'.send("")<left><Left>SynthDefLibrary.tree<cr>
map <localleader>u $F"vF"c
nmap <localleader>< m`:call SelectPart()<CR>,.<ESC>,,``
"cursor
nmap <localleader>cu :call SetCursor()<CR>
nmap <localleader>ch :call PlayFromHere()<CR>
nmap <localleader>cH :call PlayFromHere()<CR>,p
]] )

