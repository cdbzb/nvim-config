" MY SUPERCOLLIDER VIMSCRIPTS! "
"

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

function! NumSections()
  redir => cnt
    silent exe '%s/' . 'addLine' . '//gn'
  redir END

  let res = strpart(cnt, 0, stridx(cnt, " "))
  return res
endfunction	

function! SelectPart () "range
	" get Song.cursor
	" set cursor of just past part
	call SetPartCursor()
	call search('\(P.tune\|P.multiStill\|P.still\|P\|P.rpp\|P.synthV\|P.synthVs\|P.double\|P.lazyV\|P.lazyDouble\)(',"b")
	execute "normal 0V%"
	call feedkeys(":call SetPartCursorToNil()\<CR>")

	"call v:lua.feedkeys(":call SetPartCursorToNil()\<CR>")
	" call SetPartCursorToNil()
endfunction

function! RenderNextSynthV ()
	execute "/P.\\(synthV\\|double\\)"
	execute "normal ,vr"
endfunction

function! FoldParts (lnum)
	let save_cursor=getcurpos()
	let thisline=getline(a:lnum)
	let nextline=getline(a:lnum+1)
	if match(thisline, '^P\.*\a*(\s*') >= 0
		return '>3'
	elseif match(thisline, '}*);') == 0
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
	else 
		return '='
		endif

endfunction
function! Testmatch ()

	let thisline=getline(".")
	echo match(thisline, '^\s*\a\+\s*{')
endfunction

"set foldmethod=expr
set foldexpr=FoldParts(v:lnum)

function! InsertDurs()
	exe "normal mm"
	exe "normal $F]V%"
	call scnvim#send_selection()
	exe "sleep 100m"
	call v:lua.require'scnvim'.send("Song.writeDurs(Song.sections-1)")
	exe "sleep 100m"
	normal `m\<ESC>
	exe "sleep 100m"
	exe " read /tmp/durs"
	exe "sleep 100m"
	normal \<ESC>
endfunction



"function! CountSectionNumber()
"	let cursor = line('.')
"	let total = 0
"	while cursor > 0
"		let total = total + 1
"		let cursor = cursor - 1
"	endwhile
"	echo total
"endfunction

function!RecordSection()
	let line = getline(".")
	let lyric = matchstr(line,"\".*\" *,",0,0)
	let lyric = substitute(lyric,"\" *,","\"",'g')
	let lyric = "Song.section(" . lyric . ")"
	let lyric = "Song.rhythm(" . lyric . ",1)"
	call v:lua.require'scnvim'.send(lyric)
	"return lyric
	"echom lyric
	endfunction


function! SetCursor()
	call inputsave()
	let number = input('cursor?')
	call inputrestore()
	let command="Song.currentSong.cursor_(" . number . ")"
	call v:lua.require'scnvim'.send(command) 
	"call v:lua.require'scnvim'.send(command)
endfunction


function! PlayFromHere()
	exe "normal $"
	let line = search("addLine","bnc")
	let line = getline(line)
	" this line was to convert old single quoted lines
	" let line = substitute(line,"\'","\"",'g')
	let lyric = matchstr(line,"\"[\^\"]*\"",0,0)
	let lyric = substitute(lyric,"\" *,","\"",'g')
	let section= "Song.section(" . lyric . ")"
	let command="Song.currentSong.cursor_(" . section. ")"
	call v:lua.require'scnvim'.send(command)
endfunction

function! GetStartString()
	exe "normal $"
	let line = search("addLine","bnc")
	let line = getline(line)
	let lyric = matchstr(line,"\"[\^\"]*\"",0,0)
	let lyric = substitute(lyric,"\" *,","\"",'g')
	let section= "Song.section(" . lyric . ")"
	let command="Song.currentSong.getStartString(" . section. ")"
	call v:lua.require'scnvim'.send(command)
endfunction

function! SetPartCursor()
	let sectionNumber = GetSectionNumber()
	let setPartCursor = "Song.partCursor_(" . GetSectionNumber() . ")"
	call v:lua.require'scnvim'.send(setPartCursor)
endfunction

function! SetPartCursorToNil()
	call v:lua.require'scnvim'.send("Song.partCursor_(nil)")
endfunction

function! GetSectionNumber()
	exe "normal $"
	let line = search("addLine","bnc")
	let line = getline(line)
	let line = substitute(line,"\'","\"",'g')
	let lyric = matchstr(line,"\"[\^\"]*\"",0,0)
	let lyric = substitute(lyric,"\" *,","\"",'g')
	let section= "Song.section(" . lyric . ")"
	echo section
	return section
endfunction

function! RenderSynthV()
	call SelectPart()
	sleep 0.1
	call v:lua.require'scnvim.editor'.send_selection()
	sleep 0.1
	call v:lua.require'scnvim'.send("Part.current.synthV.render")
endfunction

function! NowPlayAgain()
	call v:lua.require'scnvim'.send("z = Song.currentSong.cursor")
	call v:lua.require'scnvim.editor'.send_block()
	"call scnvim#send_block()
	call v:lua.require'scnvim'.send("Song.currentSong.cursor_(z)")
	"call v:lua.require'scnvim'.send("Song.currentSong.playAfterLoad")
	call v:lua.require'scnvim'.send("Song.currentSong.play")
endfunction

function! Transpose()
	execute "s/(\\c)/('c#')/g"
endfunction

function! CleanSnippet()
	execute 's/\<\a\+\>:_/_/'
	execute 's/\<mul:.\+,\sadd:.*)/)/'
endfunction



"let g:which_key_map={}
"call which_key#register(',', "g:which_key_map")

nmap <leader>X ,x,<
nmap <leader>Z ,x,p
