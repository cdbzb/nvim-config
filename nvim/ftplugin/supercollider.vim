" MY SUPERCOLLIDER VIMSCRIPTS! "

function! Testy()
	echom "working!"
endfunction

function! CheckIsAddLineStart2(lnum)
	let save_cursor=getcurpos()
	call cursor(a:lnum,0)
	let endline= searchpairpos('\[','','\]','n')[0]
	if match(getline(endline),"addLine")  >= 0
		let returnValue = '>2'
	else
		let returnValue = '-1'
	endif
	call setpos('.',save_cursor)
	return returnValue
endfunction

function! CheckIsCodeBlock(lnum)
	let save_cursor=getcurpos()
	call cursor(a:lnum,0)
	let endline= searchpairpos('\(','','\)','n')[0]
	if match(getline(endline),"^)$")  >= 0
		let returnValue = '>1'
	else
		let returnValue = -1
	endif
	call setpos('.',save_cursor)
	return returnValue
endfunction

function! FoldParts (lnum)
	let save_cursor=getcurpos()
	let thisline=getline(a:lnum)
	let nextline=getline(a:lnum+1)
	if match(thisline, 'P(') >= 0
		return '>3'
	elseif match(thisline, 'P.still(') >= 0
		return '>3'
	elseif match(thisline, 'P.tune(') >= 0
		return '>3'
	elseif match(thisline, ');') == 0
		return '<3'
	elseif match(thisline, 'MUTED);')  >0
		return '<3'
	elseif match(thisline, '(') == 0
	"	return CheckIsCodeBlock(a:lnum)
		return '>3'
	elseif match(thisline,"addLine") >= 3
		return '>2'
		"only if NOT in a []!
	elseif match(thisline, '[') == 0
		return CheckIsAddLineStart2(a:lnum)
	elseif match(nextline,"addLine") >= 4
		return '<2'
	elseif match(thisline,'\\MUTED') >= 0 
		return 3
	elseif match(thisline, 'SynthDef') >= 1 && match(thisline, 'SynthDef')<4
		return '>4'
"		return 'a1'
	elseif match(thisline, ')\.add;') >= 1 && match(thisline, ')\.add;') <4
		return '<4'
	elseif match(thisline, 'SynthDef') == 0 
		return '>2'
"		return 'a1'
	"elseif match(thisline, ')\.add;') == 1
	"	return '<2'
		"return 's1'
		"return -1
		"return 's1'
	"elseif match(thisline,")$") = 0
	"	return '<1'
	else 
		"return -1
		return '='
		endif

endfunction

"set foldmethod=expr
set foldexpr=FoldParts(v:lnum)

function! InsertDurs()
	exe "normal mm"
	exe "normal $F]V%"
	call scnvim#send_selection()
	exe "sleep 100m"
	call scnvim#sclang#send("Song.writeDurs(Song.sections-1)")
	exe "sleep 100m"
	normal `m\<ESC>
	exe "sleep 100m"
	exe " read /tmp/durs"
	exe "sleep 100m"
	normal \<ESC>
endfunction

function!RecordSection()
	let line = getline(".")
	let lyric = matchstr(line,"\".*\",",0,0)
	let lyric = substitute(lyric,"\",","\"",'g')
	let lyric = "Song.section(" . lyric . ")"
	let lyric = "~recorder.(Song.currentSong," . lyric . ",1)"
	call scnvim#sclang#send(lyric)
	"return lyric
endfunction


function! SetCursor()
	call inputsave()
	let number = input('cursor?')
	call inputrestore()
	let command="Song.currentSong.cursor_(" . number . ")"
	call scnvim#sclang#send(command)
endfunction


function! PlayFromHere()
	let line = getline(".")
	let lyric = matchstr(line,"\".*\",",0,0)
	let lyric = substitute(lyric,"\",","\"",'g')
	let section= "Song.section(" . lyric . ")"
	let command="Song.currentSong.cursor_(" . section. ")"
	call scnvim#sclang#send(command)
endfunction


function! NowPlayAgain()
	call scnvim#sclang#send("z = Song.currentSong.cursor")
	call scnvim#send_block()
	call scnvim#sclang#send("Song.currentSong.cursor_(z)")
	call scnvim#sclang#send("Song.currentSong.play")
endfunction


nmap <localleader>rec :call RecordSection() 
nmap <localleader>P :call NowPlayAgain()<CR>
let which_key_map.P = 'reload and play'
nmap <localleader>dp yaw :call scnvim#sclang#send("")<left><left>Synth( \\<C-R>" )<CR>
nmap <localleader>p :call scnvim#sclang#send("Song.play")<CR>
let which_key_map.p = 'play Song'
nmap <localleader>< m`:call SelectPart()<CR>,l,,``
let which_key_map['<'] = 'reload part + play'
nmap <localleader>ii yaw:call scnvim#sclang#send("Song.current.<C-r>".play")<CR>
nmap <localleader>, :call scnvim#sclang#send("Part.play")<CR>
let which_key_map[','] = 'play part'
nmap <localleader>sd :call scnvim#sclang#send("")<left><Left>
nmap <localleader>st :SCNvimStart<CR>
nmap <localleader>sp :SCNvimStop<CR>
nmap <localleader>k <ESC>:w<ENTER>:SCNvimRecompile<ENTER>
let which_key_map.k = 'recompile'
nmap <localleader>x :call scnvim#sclang#send("~myFree.()")<CR>
let which_key_map.x = 'myFree'
nmap zx :call scnvim#sclang#send("~myFree.()")<CR>
nmap <localleader>z <Plug>(scnvim-hard-stop)
nmap zz <Plug>(scnvim-hard-stop)
nmap <localleader>. <Plug>(scnvim-send-block)
let which_key_map['.'] = 'send block'
nmap <localleader>l <Plug>(scnvim-send-line)
vmap <localleader>l <Plug>(scnvim-send-selection)
let which_key_map['l'] = 'send line/sel'
nmap <localleader>sc <Plug>(scnvim-postwindow-clear)
map <localleader>rpp m`ggl"zy$:!tmux new -d "open -a REAPER64.app <C-r>z"<CR>``
"map <localleader>P <F5><ENTER>``,p
nnoremap <localleader>df :silent execute "grep! -r SynthDef.*" . shellescape(expand("<cword>")) . " ~/tank/super/SynthDefLibrary/*"<cr>:copen<cr>
nnoremap <localleader>dc yaw :call scnvim#sclang#send("")<left><Left>SynthDescLib.at(  \\<C-r>"  ).dump<cr>
nnoremap <localleader>dt     :call scnvim#sclang#send("")<left><Left>SynthDefLibrary.tree<cr>
map <localleader>u $F"vF"c
let which_key_map.u = 'edit tune'
"cursor
nmap <localleader>cu :call SetCursor()<CR>
nmap <localleader>ch :call PlayFromHere()<CR>
nmap <localleader>cH :call PlayFromHere()<CR>,p

"  Menus
let g:which_key_map.c = {
			\ 'name': '+cursor',
			\ 'u' : 'input',
			\ 'h' : 'set here',
			\ 'H' : 'set here and play',
			\ }
let g:which_key_map.s = {
			\ 'name': 'sclang',
			\ 't' : 'start',
			\ 'p' : 'stop',
			\ 'd' : 'send',
			\ 'c' : 'clear',
			\ }
let g:which_key_map.d = {
			\ 'name': '+synthDefs',
			\ 'c' : 'controls',
			\ 't' : 'tree',
			\ 'f' : 'find',
			\ }
