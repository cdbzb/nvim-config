wk = require("which-key")
tb = require("telescope.builtin")
utils = require("telescope.utils")
-- tk = require("telekasten")
sc = require("scnvim")

wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    triggers = {
        { " ", mode = { "n", "v" } },
        { ",", mode = { "n", "v" } },
        { "<auto>", mode = "nxsotc" },
        { "a", mode = { "n", "v" } },
    }
}

wk.add({
  { "<space>fnb", "<Plug>(neorg.telescope.backlinks.file_backlinks)", desc = "backlinks (File)" },
  { "<space>fnB", "<Plug>(neorg.telescope.backlinks.header_backlinks)", desc = "backlinks (header)"},
  { "<space>fnh", "<Plug>(neorg.telescope.find_linkable)", desc = "find heading" },
  { "<space>fnn", "<Plug>(neorg.telescope.find_norg_files)", desc = "find note" },
  { "<space>fnl", "<Plug>(neorg.telescope.insert_file_link)", desc = "insert link (file)" },
  { "<space>fnL", "<Plug>(neorg.telescope.insert_link)" , desc = "insert link (block)" },
  { "<space>fnH", "<Plug>(neorg.telescope.search_headings)", desc = "headings (local)" },
  { "<localleader>nd", "<Plug>(neorg.looking-glass.magnify-code-block)", desc = "send code block to new buf"},
  { "<space>nD","i* <C-R>=strftime('%b %d, %Y')<CR>", desc = "journal date entry" },

  -- Leader mappings
  { "<leader>j", group = "jump" },
  { "<leader>jl", "/GaddLine<enter>z.", desc = "nextline" },

  { "<leader>b", group = "buffers" },
  { "<leader>be", ":call DeleteEmptyBuffers()<CR>", desc = "delete empty" },
  { "<leader>bb", ":source /Users/michael/.config/nvim/lua/config/bufferline.lua", desc = "source bufferline.lua"},
  { "<leader>bw", ":lua MiniBufremove.wipeout()<CR>", desc = "miniBuf Wipeout" },
  { "<leader>bd", ":lua MiniBufremove.wipeout()<CR>", desc = "miniBuf Delete" },
  { "<leader>bU", ":lua MiniBufremove.unshow()<CR>", desc = "miniBuf Unshow All" },
  { "<leader>bu", ":lua MiniBufremove.unshow_in_window()<CR>", desc = "miniBuf Unshow in Win" },

  { "<leader>e", group = "edit" },
  { "<leader>ec", ":e ~/.config/nvim/lua <CR>", desc = "nvim lua config" },
  { "<leader>ew", ":e ~/.config/nvim/lua/config/which-key.lua <CR>", desc = "which-key config" },

  { "<leader>f", group = "Find Files" },
  { "<leader>fd", function() require'telescope'.extensions.supercollider.sc_definitions() end, desc = "sc defs"},
  { "<leader>fD", function() require'telescope'.extensions.scdoc.scdoc() end, desc = "sc docs" },
  { "<leader>fs", function() tb.find_files({ cwd='/Users/michael/tank/super/Trek/Songs/' }) end, desc = "Songs" },
  { "<leader>fm", function() tb.find_files({ cwd='/Users/michael/tank/super/scd/Mandarin/' }) end, desc = "Mandarin" },
  { "<leader>fc", function() tb.find_files({ cwd='/Users/michael.config' }) end, desc = "config" },
  { "<leader>fo", function() tb.oldfiles() end, desc = "Recent" },
  { "<leader>ft", function() tb.tags({ path_display = { "smart" } }) end, desc = "Tags" },
  { "<leader>fc", function() tb.find_files({ cwd='~/tank/super/Trek/MW-Classes/' }) end, desc = "My Classes" },
  { "<leader>fh", function() tb.find_files({ cwd=utils.buffer_dir() }) end, desc = "Here" },
  { "<leader>fb", function() tb.buffers() end, desc = "Buffers" },
  { "<leader>fk", function() tb.keymaps() end, desc = "Keymaps" },
  { "<leader>fr", function() require'telescope'.extensions.orgmode.search_headings() end, desc = "org" },

  { "<leader>fg", group = "grep" },
  { "<leader>fgl", function() tb.live_grep({cwd='/Users/michael/Documents/Logseq'}) end, desc = "LogSeq" },
  { "<leader>fgd", function() tb.live_grep({cwd='/Users/michael/tank/super/Trek/SynthDefLibrary/'}) end, desc = "SynthDefs" },
  { "<leader>fgs", function() tb.live_grep({cwd='/Users/michael/tank/super/Trek/Songs'}) end, desc = "Songs" },
  { "<leader>fgk", function() tb.live_grep({cwd='/Users/michael/tank/super/Trek'}) end, desc = "Trek" },
  { "<leader>fgc", function() tb.live_grep({cwd='/Users/michael/tank/super/Trek/MW-Classes'}) end, desc = "my classes" },
  { "<leader>fgh", function() tb.live_grep() end, desc = "here" },

  { "<leader>fGb", function() tb.git_bcommits() end, desc = "git buffer commits"},
  { "<leader>f?", function() tb.commands() end, desc = "commands"},

  { "<leader>j", group = "neorg journal" },
  { "<leader>jj", ":Neorg journal today <cr>", desc = "today"},
  { "<leader>jt", ":Neorg journal toc <cr>", desc = "toc"},
  { "<leader>ji", ":Neorg index <cr>", desc = "index"},

  { "<leader>w", group = "Window" },
  { "<leader>wo", ":only<cr>", desc = "only" },
  { "<leader>wj", "<C-w>j", desc = "next" },
  { "<leader>wk", "<C-w>k", desc = "previous" },
  { "<leader>wh", "<C-w>h", desc = "left" },
  { "<leader>wl", "<C-w>l", desc = "right" },
  { "<leader>wc", "<C-w>c", desc = "close" },

  { "<leader>a", function() sc.send("Date.insertStamp") end, desc = "Insert Timestamp"},

  { "<leader>t", group = "terminal" },
  { "<leader>tt", ":ToggleTerm<CR>", desc = "ToggleTerm" },

  { "<leader>l", group = "launch" },
  { "<leader>lg", ":Neogit<CR>", desc = "NeoGit"},

  { "<leader>n", group = "notes" },
  { "<leader>nP", ":!~/.config/nvim/scripts/push-org.sh<CR>", desc = "push org-roam"},
  { "<leader>np", ":!~/.config/nvim/scripts/pull-org.sh<CR>", desc = "pull org-roam"},

  -- LocalLeader mappings
  { "<localleader>", group = "SC commands" },
  { "<localleader>P", ":call NowPlayAgain()<CR>", desc = "reload and play" },
  { "<localleader>p", function() require'scnvim'.send("Song.play") end, desc = "play Song" },
  { "<localleader>o", function() require'scnvim'.send("Song.makeScroll") end, desc = "makeScroll"},
  { "<localleader><", desc = "reload part and play" },
  { "<localleader>,", desc = "play Part" },
  { "<localleader>f", ":set ft=supercollider<CR>", desc = "set filetype" },
  { "<localleader>k", desc = "recompile" },
  { "<localleader>l", desc = "send line/selection" },

  { "<localleader>m", group = "monitors" },
  { "<localleader>mf", function() sc.send("Monitors.gui") end, desc = "volume fader"},
  { "<localleader>mm", function() sc.send("s.volume_(-90); Monitors.gui") end, desc = "volume fader"},
  { "<localleader>ma", function() require'scnvim'.send("Monitors.airpods") end, desc = "airpods"},
  { "<localleader>mb", function() require'scnvim'.send("Monitors.bose") end, desc = "bose"},
  { "<localleader>mh", function() require'scnvim'.send("Monitors.headphones") end, desc = "headphones"},
  { "<localleader>mz", function() require'scnvim'.send("Monitors.zoom") end, desc = "zoom"},
  { "<localleader>mt", function() require'scnvim'.send("().play") end, desc = "test"},

  { "<localleader>u", desc = "play this tune" },
  { "<localleader>n", function() require'scnvim'.send("Song.playOnly()") end, desc = "play Only Again"},
  { "<localleader>N", [[:call v:lua.require'scnvim'.send("Song.playOnly(\\)")<LEFT><LEFT><LEFT>]], desc = "play only" },
  { "<localleader>.", desc = "send block" },

  { "<localleader>d", group = "synthDefs" },
  { "<localleader>dc", desc = "controls" },
  { "<localleader>dt", desc = "tree" },
  { "<localleader>df", desc = "find" },
  { "<localleader>dp", desc = "play" },

  { "<localleader>c", group = "cursor" },
  { "<localleader>cu", desc = "input" },
  { "<localleader>ch", desc = "Here" },
  { "<localleader>cH", desc = "set Here and Play Song" },
  { "<localleader>cd", function() require'scnvim'.send("Song.cursor_(Song.cursor - 1)") end, desc = "decrement"},

  { "<localleader>s", group = "sclang" },
  { "<localleader>st", desc = "start" },
  { "<localleader>sp", desc = "stop" },
  { "<localleader>sc", function() require'scnvim.postwin'.clear() end, desc = "clear Post" },
  { "<localleader>sd", desc = "send to sclang" },
  { "<localleader>sb", function() sc.send("s.newBusAllocators") end, desc = "new BusAllocators"},
  { "<localleader>sm", function() sc.send("Song.makeScroll") end, desc = "Make Song Scroll"},
  { "<localleader>sf", function() sc.send("PF()") end, desc = "make a piano!"},
  { "<localleader>ss", function() sc.send("s.boot") end, desc = "boot server"},

  { "<localleader>sg", function() send_midi_item_gui_under_cursor() end, desc = "send MIDIItem.gui" } ,
  { "<localleader>sG", function() send_register_d_gui() end, desc = "send register D.gui" } ,
  { "<localleader>/", function()
      vim.api.nvim_call_function("SelectPart",{})
      require'scnvim.editor'.send_selection()
    end, desc = "reload part without playing" },

  { "<localleader>i", group = "ii for part name under cursor" },
  { "<localleader>ii", desc = "play part under cursor" },

  { "<localleader>r", group = "record section - RPP" },
  { "<localleader>re", ":call RecordSection()<CR>", desc = "record section" },
  { "<localleader>ro", function() sc.send("Part.current.rpp.open") end, desc = "open RPP" },
  { "<localleader>rb", function() sc.send("Part.current.rpp.build") end, desc = "build RPP" },

  { "<localleader>v", group = "synthVs" },
  { "<localleader>vo", function() sc.send("Part.current.synthV.open") end, desc = "open synthV" },
  { "<localleader>vr", function() 
      vim.api.nvim_call_function("SelectPart",{})
      require'scnvim.editor'.send_selection()
      sc.send("Part.current.synthV.render")
    end, desc = "render synthV" },
  { "<localleader>ve", function()
      sc.send("SynthV.current.render")
    end, desc = "synthV.current.render" },
  { "<localleader>vR", function() 
      vim.api.nvim_call_function("SelectPart",{})
      require'scnvim.editor'.send_selection()
      sc.send("SynthV.renderMultiple")
    end, desc = "render synthVs" },
  { "<localleader>vs", function ()
      vim.api.nvim_call_function("PlayFromHere",{})
      sc.send("SynthV.renderSection")
    end, desc = "render SynthVs in section" },

  { "<localleader>a", group = "arm" },
  { "<localleader>ao", function() sc.send("RecOnsets.record") end, desc = "RecOnsets"},
  { "<localleader>ak", function() sc.send("RecKey.record") end, desc = "RecKey"},
  { "<localleader>ae", function() sc.send("RecEnv.record") end, desc = "RecEnv"},
  { "<localleader>ar", function() sc.send("Rec.record") end, desc = "Rec"},

  { "<localleader>w", group = "Window" },
  { "<localleader>wc", function() sc.send("Window.closeAll") end, desc = "closeAll"},
})
vim.cmd( [[
" imap <C-return> lua require'neorg'.itero.next-iteration()

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
nnoremap <localleader>df :silent execute "grep! SynthDef.*" . shellescape(expand("<cword>")) . " ~/tank/super/Trek/SynthDefLibrary/*"<cr>:copen<cr>
nnoremap <localleader>dc yaw :call v:lua.require'scnvim'.send("")<left><Left>SynthDescLib.at(  \\<C-r>"  ).dump<cr>
nnoremap <localleader>dt     :call v:lua.require'scnvim'.send("")<left><Left>SynthDefLibrary.tree<cr>
map <localleader>u $F"vF"c
nmap <localleader>< m`:call SelectPart()<CR>,.<ESC>,,``
"cursor
nmap <localleader>cu :call SetCursor()<CR>
nmap <localleader>ch :call PlayFromHere()<CR>
nmap <localleader>cH :call PlayFromHere()<CR>,p
]] )

