let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

lua require('config')

nmap s <Plug>Lightspeed_s

autocmd filetype supercollider lua require'reaper-nvim'.setup()
lua <<EOF
vim.g['reaper_target_ip'] = '127.0.0.1'
--vim.g.port= '8000'
EOF

"org setup
set conceallevel=2
set concealcursor=nc

nmap <leader>w <c-w>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set sessionoptions+=tabpages,globals
set sessionoptions-=options
set viewoptions-=options
set sessionoptions-=help,buffers


let g:ctrlp_working_path_mode = 'r'
"'/Users/michael/.config/nvim/plugged/scnvim/scnvim-data']

""""""
"folding
""""""

map z1 :set foldlevel=1<CR>
map z2 :set foldlevel=2<CR>

" opening temp scd buffer
map <leader>tmp :split /tmp/scd.scd<CR>:resize 10<CR>

"netrw
let g:netrw_winsize=25

"terminal
tnoremap <Esc> <C-\><C-n>

"fold color
"deoplete + neosnippet + autopairs
let g:AutoPairsMapCR=1
let g:AutoPairsSpace = 0

inoremap <buffer> <silent> <S-Space> <C-R>=AutoPairsSpace()<CR>
let g:deoplete#enable_smart_case = 1

map <leader>init :e ~/.config/nvim/init.vim<ENTER>

autocmd CompleteDone * silent! pclose!


"imap ,) <esc>ldt)

"inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
"highlight Folded ctermbg=Black
"SCNVIM autocommand
autocmd FileType supercollider exe "silent! call scnvim#sclang#open()"

"let &packpath = &runtimepath
"source ~/.vimrc

" FROM VIMRC
set rtp+=/usr/local/opt/fzf

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
filetype off
set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim/
filetype on
syntax on
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let NERDTreeShowHidden=1
" Lilypond
filetype plugin on
autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete

set autochdir

""""""""""""""""""""""
" for save view    ""
""""""""""""""""""""""
"set viewoptions=cursor,folds,slash,unix
"
"
"
"
"""""""""""""""""""""""""""""""
" my maps!!!!
"""""""""""""""


"""""""""""
" scnvim ""
"""""""""""


set titlestring=%f
set title
"vmap <LEADER>l <Plug>(scnvim-send-selection)
"let swithchbuf +=useopen
"map <LEADER>L ``:b clang<ENTER>Gm`P
"imap <LEADER>l <ESC>,l
map  <LEADER>; <ESC>A;<ESC>
nmap <Space>p <Plug>(scnvim-postwindow-toggle)

"open associated RPP (at top of file)

"for lilypond
"map ,swap "adabl"bdab"aPF|;"bP
cmap halve !perl -pe 's/(\d+)/$1*.5/eg'
cmap double !perl -pe 's/(\d+)/$1*2/eg'
" map <F5> :w<bar>:!lilypond -o=% % <CR> <ENTER> 
"map <F5> :w<bar>:!tmux new -d "lilypond % %"<CR> <ENTER> 
"map <Leader>. <F5><ENTER>``
"map ,p ,zxcv<ENTER>
"map ,p :!mupdf $(basename "%" .ly).pdf &
" map png :w<bar>:!lilypond --png -o % %<CR>
""""""
"Lilypond stuff
"map ?? :! open -a Firefox.app http://lilypond.org/doc/v2.12/Documentation/user/lilypond/LilyPond-index<CR>
"map <Leader>snip :e ~/.vim/snippets/lilypond.snippets
"let @y = '"ayt|/lyricf{l"byt}j0"cyt|f|l"dyt|' "copies the music for merging
"let @p = 'f|"aP/lyrf}"bPa j0f|"cPf|;"dP' "pastes
"let @i = '/lyricn/|n0@o' 

":vnoremap ab :<C-U>call SelectBar()<CR>
"omap ab :normal vab<CR>

map <Leader>gf Y:!open <C-r>"<BACKSPACE> 
colorscheme peaksea
" set gfn=Menlo:h21
set background=dark
colorscheme peaksea


map <Leader>xx <Plug>VimwikiToggleListItem
"let g:vimwiki_list= [{'path':'~/myhack/Volumes/Zippy/puddle/vimwiki/', 'path_html':'~/myhack/Volumes/Zippy/puddle/vimwiki/export/html/'}]
   " Settings for Vimwiki
   let g:vimwiki_list = [{'path':'~/Documents/vimwiki/markdown/','ext':'.md', 'syntax':'markdown'}]

""""""""""""""""""""
" command mode stuff
" """""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile
map <D-d> :NERDTreeToggle <CR>
let NERDTreeSortOrder=[ '[[-timestamp]]','\/$','*', '\.swp$',  '\.bak$', '\~$']


"""""""""""""""
"cursor
"""""""""""""""

let &t_SI = "\<Esc>]12;orange\x7"
let &t_EI = "\<Esc>]12;red\007"
"let &t_EI .= "\<Esc>[6 q"
silent !echo -ne "\033]12;red\007"
autocmd VimLeave * silent !echo -ne "\033]112\007"

""""""""""""""""""
" save folds
" """""""""""""
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
hi Folded ctermbg=238
"inoremap zz <C-O>za
"nnoremap zz za
"onoremap zz <C-C>za
"vnoremap zz zf

set hidden

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


"""""""""""
" scvim "
""""""""
"let g:scSplitDirection="v"
"let g:scSplitSize="30"

""""" scrollbar

func! STL()
  let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
  let barWidth = &columns - 65 " <-- wild guess
  let barWidth = barWidth < 3 ? 3 : barWidth

  if line('$') > 1
    let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
  else
    let progress = barWidth/2
  endif

  " line + vcol + %
  let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
  let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
        \.repeat('-',progress )
        \.'%2*0%1*'
        \.repeat('-',barWidth - progress - 1).'%0*%)%<]'

  return stl.bar
endfun

hi def link User1 DiffAdd
hi def link User2 DiffDelete
set stl=%!STL() 

function! FoldBetweenLines ()
	execute "normal mm"
	call setpos( "." , [0,0,0])
	 while search("addLine","W") >0
		execute "silent! normal zd"
		execute "normal zfnn"
	endwhile
		execute "normal `m"
endfunction

function! FoldAllParts ()
	execute "normal mm"
	call setpos( "." , [0,0,0])
	 while search("P(","W") >0
		execute "silent! normal zd"
		execute "normal lzf%l"
	endwhile
		execute "normal `m"
endfunction


function! SelectPart () "range
	"call search("P(","b")
	call search('\(P.tune\|P.still\|P\)(',"b")
	execute "normal 0V%"
endfunction

function! CopyLineFromPostWindow ()
	execute "normal mQ"
	execute "b sclang"
	execute "normal G0v$hy`Q"
endfunction

map zge :call CopyLineFromPostWindow()<CR>

"map zdf :call LookupDefUnderCursor()<CR>
" 808

"fzf
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

nmap sleep :!pmset sleepnow<CR>

""""""
"CtrlP
"""""


nmap <C-k> lua echo_sc_args()

autocmd BufNewFile *.sc :set foldexpr=nvim_treesitter#foldexpr()
"autocmd BufAdd *.scd SCNvimStart

map ,hm /^\s*\**\a\+\s*{<cr>
map z0 :set foldlevel=0<CR>
map ,ft :set foldmethod=nvim_treesitter#foldexpr()

nmap <leader>ts i<C-R>=strftime("%Y%m%d_%I%M%S")<CR><Esc>

"hi link NormalFloat ModeMsg
hi link FloatBorder TermCursorNC
hi NormalFloat      ctermfg=lightgrey   ctermbg=17

" on hesitation, bring up the panel
nnoremap <leader>z :lua require('telekasten').panel()<CR>

" we could define [[ in **insert mode** to call insert link
" inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
" alternatively: leader [
inoremap <leader>[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>

" ----- the following are for syntax-coloring [[links]] and ==highlighted text==
" ----- (see the section about coloring in README.md)

" for gruvbox
hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
hi tkBrackets ctermfg=gray guifg=gray

" real yellow
hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
" gruvbox
"hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

hi link CalNavi CalRuler
hi tkTagSep ctermfg=gray guifg=gray
hi tkTag ctermfg=175 guifg=#d3869B
