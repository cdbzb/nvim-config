let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



let g:neosnippet#disable_runtime_snippets={'_':1,}

let g:python3_host_program='/usr/bin/python3'
call plug#begin()
" Reaper
Plug 'madskjeldgaard/reaper-nvim'
" OSC
Plug 'davidgranstrom/osc.nvim'
"Plug 'Shougo/neosnippet.vim'
Plug 'preservim/nerdtree'
Plug 'liuchengxu/vim-which-key'

" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" To register the descriptions when using the on-demand load feature,
" use the autocmd hook to call which_key#register(), e.g., register for the Space key:
" autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'maxboisvert/vim-simple-bookmarks'
Plug 'davidgranstrom/scnvim',{'do':{-> scnvim#install() } }
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/peaksea'
"Plug 'vim-scripts/bufexplorer.zip'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'gcmt/taboo.vim'
Plug 'vim-scripts/utl.vim'
"Plug 'thaerkh/vim-workspace'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end() 
 set rtp+=/usr/local/opt/fzf
autocmd filetype supercollider lua require'reaper-nvim'.setup()
lua <<EOF
vim.g.reaper_target_ip = '127.0.0.1'
vim.g.port= '8000'
EOF
autocmd filetype supercollider lua require'reaper-nvim'.setup()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set sessionoptions+=tabpages,globals
set sessionoptions-=help,buffers
let g:deoplete#enable_at_startup = 1

  "let g:python3_host_prog = '/usr/local/bin/python3'
" control P stuff
let g:ctrlp_working_path_mode = 'r'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data','/Users/michael/tank/super/UltiSnips']
"'/Users/michael/.config/nvim/plugged/scnvim/scnvim-data']

let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/scnvim/scnvim-data'
let g:neosnippet#disable_runtime_snippets = {
		\   '_' : 1,
		\ }
"let g:neosnippet#snippets_directory = 'plugged/scnvim/scnvim-data'
""""""
"folding
""""""

map z1 :set foldlevel=1<CR>
map z2 :set foldlevel=1<CR>

" opening temp buffer
map ,tmp :split tmp/scd.scd<CR>:resize 10<CR>
""""""
"CtrlP
"""""
nmap zfr :CtrlPMRU<CR>

"netrw
let g:netrw_winsize=25

"bookmarks
"
nnoremap <Leader>bk :SimpleBookmarksAdd<CR>
nnoremap <Leader>BK :SimpleBookmarksList<CR>

"terminal
tnoremap <Esc> <C-\><C-n>

"fold color
"deoplete + neosnippet + autopairs
let g:AutoPairsMapCR=0
let g:deoplete#enable_smart_case = 1

map ,init :e ~/.config/nvim/init.vim<ENTER>

  function UltiSnips_IsExpandable()
    return !(
      \ col('.') <= 1
      \ || !empty(matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\s'))
      \ || empty(UltiSnips#SnippetsInCurrentScope())
      \ )
  endfunction


autocmd CompleteDone * silent! pclose!

"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

imap <expr><TAB> pumvisible() ? "\<C-n>" : UltiSnips_IsExpandable() ?  "<C-R>=UltiSnips#ExpandSnippetOrJump()<cr>" : "\<TAB>"

"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
inoremap <expr><S-TAB> pumvisible() ? deoplete#complete() : "\<CR>"

let g:UltiSnips#ExpandTrigger="\<S-Tab>"

imap ,) <esc>ldt)

"inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
"highlight Folded ctermbg=Black
"SCNVIM autocommand
"autocmd FileType supercollider exe "silent! call scnvim#sclang#open()"

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
map Q gq

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
let mapleader = ","


"""""""""""
" scnvim ""
"""""""""""
set titlestring=%f
set title
let g:scnvim_scdoc = 1
let g:scnvim_postwin_size = 50
let g:scnvim_eval_flash_repeats = 0
nmap ,p :call scnvim#sclang#send("Song.play")<CR>
nmap zp m`:call SelectPart()<CR>,l,,``
nmap ,ii yaw:call scnvim#sclang#send("Song.current.<C-r>".play")<CR>
nmap ,, :call scnvim#sclang#send("Part.play")<CR>
nmap ,sc :call scnvim#sclang#send("")<left><Left>
nmap ,st :SCNvimStart<CR>
nmap ,sp :SCNvimStop<CR>
nmap zk <ESC>:w<ENTER>:SCNvimRecompile<ENTER>:silent!open -a iTerm<RETURN>
nmap zx :call scnvim#sclang#send("~myFree.()")<CR>
nmap <LEADER>. <Plug>(scnvim-send-block)
"vmap <LEADER>l <Plug>(scnvim-send-selection)
"let swithchbuf +=useopen
"map <LEADER>L ``:b clang<ENTER>Gm`P
nmap <LEADER>l <Plug>(scnvim-send-line)
vmap <LEADER>l <Plug>(scnvim-send-selection)
"imap <LEADER>l <ESC>,l
map  <LEADER>; <ESC>A;<ESC>
imap  <LEADER>; <ESC>,;
nmap zz        <Plug>(scnvim-hard-stop)
"| `<CR>`  | Toggle post window buffer | `<Plug>(scnvim-postwindow-toggle)` | Insert, Normal | 
nmap <LEADER>c <Plug>(scnvim-postwindow-clear)
"| `K` | Open documentation | Uses vim `keywordprg` | Normal |

"map ,line :set cursorline!<ENTER>
"open associated RPP (at top of file)
map <Leader>rpp m`ggl"zy$:!tmux new -d "open -a REAPER64.app <C-r>z"<CR>``

map ,swap "adabl"bdab"aPF|;"bP
cmap halve !perl -pe 's/(\d+)/$1*.5/eg'
cmap double !perl -pe 's/(\d+)/$1*2/eg'
" map <F5> :w<bar>:!lilypond -o=% % <CR> <ENTER> 
map <F5> :w<bar>:!tmux new -d "lilypond % %"<CR> <ENTER> 
"map <Leader>. <F5><ENTER>``
"double angle surround
map <Leader>>> S>v%S>
"map <Leader>zxcv :!tmux new -d "open  -a Skim.app <C-R>%<BS><BS><BS>.pdf"<CR>
"map ,p ,zxcv<ENTER>
"map ,p :!mupdf $(basename "%" .ly).pdf &
map <Leader>P <F5><ENTER>``,p
imap <Leader>q <ESC>m`F<vt>ly``pa
" map <Leader>p  :! open  %.pdf<CR>
" map png :w<bar>:!lilypond --png -o % %<CR>
map mid :!quit 'Quicktime Player 7'<CR>:! open -a 'Quicktime Player 7' %.midi<CR>
""""""
"Lilypond stuff
"map ?? :! open -a Firefox.app http://lilypond.org/doc/v2.12/Documentation/user/lilypond/LilyPond-index<CR>
"map <Leader>snip :e ~/.vim/snippets/lilypond.snippets
"let @y = '"ayt|/lyricf{l"byt}j0"cyt|f|l"dyt|' "copies the music for merging
"let @p = 'f|"aP/lyrf}"bPa j0f|"cPf|;"dP' "pastes
"let @i = '/lyricn/|n0@o' 
:vnoremap ab :<C-U>call SelectBar()<CR>
omap ab :normal vab<CR>
"workaround for macbook using C-f for kwmc
inoremap <c-x><c-x> <c-x><c-f>

map <Leader>gf Y:!open <C-r>"<BACKSPACE> 
colorscheme peaksea
" set gfn=Menlo:h21
set background=dark
colorscheme peaksea


map <Leader>xx <Plug>VimwikiToggleListItem
let g:vimwiki_list= [{'path':'~/myhack/Volumes/Zippy/puddle/vimwiki/', 'path_html':'~/myhack/Volumes/Zippy/puddle/vimwiki/export/html/'}]

""""""""""""""""""""
" command mode stuff
" """""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $) <esc>`>a)<esc>`<i(<esc>
vnoremap $] <esc>`>a]<esc>`<i[<esc>
vnoremap $} <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
vmap ${ "zdi{<C-R>z}<Esc> 
vmap $( "zdi(<C-R>z)<Esc> 

vmap $< "zdi<<C-R>z><Esc> 
vmap $> "zdi<<<C-R>z>><Esc> 

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
     

"""""""""
" pathogen "
"""""""""""""
    "execute pathogen#infect()

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


function! ExpandOrJump ()
	call UltiSnips#ExpandSnippetOrJump()
	return ""
endfunction

function! CopyLineFromPostWindow ()
	execute "normal mQ"
	execute "b sclang"
	execute "normal G0v$hy`Q"
endfunction

map zge :call CopyLineFromPostWindow()<CR>

nnoremap zdf :silent execute "grep! -r SynthDef.*" . shellescape(expand("<cword>")) . " ~/tank/super/SynthDefLibrary/*"<cr>:copen<cr>
nnoremap zdc yaw :call scnvim#sclang#send("")<left><Left>SynthDescLib.at(  \\<C-r>"  ).dump<cr>
nnoremap zdt     :call scnvim#sclang#send("")<left><Left>SynthDefLibrary.tree<cr>
"map zdf :call LookupDefUnderCursor()<CR>
" 808

inoremap <silent> <C-e> <c-r>=ExpandOrJump()<CR>
vnoremap <C-e> <c-r>=UltiSnips#JumpForward()<CR>
vmap <C-e> <TAB>
map ztu $F"vF"c
"fzf
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
nmap sleep :!pmset sleepnow<CR>

"Which Key
nmap <leader> :WhichKey ','<CR>
nmap <localleader> :WhichKey ' '<CR>
let maplocalleader = '<SPACE>'
