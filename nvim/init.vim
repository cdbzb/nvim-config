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
Plug 'tricktux/pomodoro.vim'
" OSC
Plug 'davidgranstrom/osc.nvim'
"Plug 'Shougo/neosnippet.vim'
Plug 'preservim/nerdtree'
"Plug 'liuchengxu/vim-which-key'

" On-demand lazy load
"Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" To register the descriptions when using the on-demand load feature,
" use the autocmd hook to call which_key#register(), e.g., register for the Space key:
" autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
"Plug 'maxboisvert/vim-simple-bookmarks'
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
"Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'vimwiki/vimwiki'
"Plug 'michal-h21/vim-zettel'
Plug 'junegunn/vim-easy-align'
Plug 'folke/which-key.nvim'
"Plug 'easymotion/vim-easymotion'
Plug 'ggandor/lightspeed.nvim'
"Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'https://github.com/alok/notational-fzf-vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-orgmode/orgmode'
Plug 'dhruvasagar/vim-dotoo'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Completion engine
" Plug 'hrsh7th/nvim-cmp'

" Completion source for tags
Plug 'quangnguyen30192/cmp-nvim-tags'
" completion source for ultisnips
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end() 

lua << EOF

local cmp = require'cmp'

cmp.setup({
snippet = {
	expand = function(args)
	--require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	end,
	},
sources = {
	{ name = 'tags' },
	--{ name = 'luasnip' }, -- For luasnip users.
}
})
EOF

let mapleader = "\<SPACE>"
let maplocalleader = ','
set timeoutlen=500

"NOTE TAKING CRAPPP!!!
" example
let g:nv_search_paths = ['/Users/michael/Documents/Notes (The Archive)']
lua <<EOF

require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]m"] = "@class.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
        ["]M"] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[m"] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        ["[M"] = "@class.outer",
      },
    },
  },
}
EOF
nmap s <Plug>Lightspeed_s
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

 triggers = {"<leader>","<localleader>"} -- or specify a list manually
  }
EOF

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

"org setup
set conceallevel=2
set concealcursor=nc
lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
org_agenda_files = {'~/tank/org/*'},
org_default_notes_file = '~/tank/org/notes.org',
org_agenda_templates = 
{ 
	t = { description = 'Task', template = '* TODO %?\n %u' },
	l = { description = 'link', template = '%a***************' }
}
	
})
EOF

" neorg setup
"lua << EOF
"    require('neorg').setup {
"        -- Tell Neorg what modules to load
"        load = {
"            ["core.defaults"] = {}, -- Load all the default modules
"            ["core.norg.concealer"] = {}, -- Allows for use of icons
"            ["core.norg.dirman"] = { -- Manage your directories with Neorg
"	    ["core.keybinds"] = { -- Configure core.keybinds
"	    config = {
"		    default_keybinds = true, -- Generate the default keybinds
"		    neorg_leader = "<Leader>o" -- This is the default if unspecified
"		    }
"	    },
"                config = {
"                    workspaces = {
"                        my_workspace = "~/neorg"
"                    }
"                }
"            }
"        },
"    }
"EOF
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
map z2 :set foldlevel=2<CR>

" opening temp scd buffer
map <leader>tmp :split /tmp/scd.scd<CR>:resize 10<CR>

"netrw
let g:netrw_winsize=25

"bookmarks
"
nnoremap <Leader>bk :SimpleBookmarksAdd<CR>
nnoremap <Leader>bK :SimpleBookmarksList<CR>

"terminal
tnoremap <Esc> <C-\><C-n>

"fold color
"deoplete + neosnippet + autopairs
let g:AutoPairsMapCR=1
let g:AutoPairsSpace = 0

inoremap <buffer> <silent> <S-Space> <C-R>=AutoPairsSpace()<CR>
let g:deoplete#enable_smart_case = 1

map <leader>init :e ~/.config/nvim/init.vim<ENTER>

  function UltiSnips_IsExpandable()
    return !(
      \ col('.') <= 1
      \ || !empty(matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\s'))
      \ || empty(UltiSnips#SnippetsInCurrentScope())
      \ )
  endfunction


autocmd CompleteDone * silent! pclose!

"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <expr><TAB> pumvisible() ? "\<C-n>" : UltiSnips_IsExpandable() ?  "<C-R>=UltiSnips#ExpandSnippetOrJump()<cr>" : "\<TAB>"

"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
inoremap <expr><S-TAB> pumvisible() ? deoplete#complete() : "\<CR>"

let g:UltiSnips#ExpandTrigger="\<S-Tab>"
let g:UltiSnips#JumpForward="<c-j>"

"imap ,) <esc>ldt)

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
let g:scnvim_scdoc = 1
let g:scnvim_postwin_size = 50
let g:scnvim_eval_flash_repeats = 0
"vmap <LEADER>l <Plug>(scnvim-send-selection)
"let swithchbuf +=useopen
"map <LEADER>L ``:b clang<ENTER>Gm`P
"imap <LEADER>l <ESC>,l
map  <LEADER>; <ESC>A;<ESC>
"imap  <LEADER>; <ESC>,;
"| `<CR>`  | Toggle post window buffer | `<Plug>(scnvim-postwindow-toggle)` | Insert, Normal | 
"| `K` | Open documentation | Uses vim `keywordprg` | Normal |

"map ,line :set cursorline!<ENTER>
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

"map zdf :call LookupDefUnderCursor()<CR>
" 808

inoremap <silent> <Tab> <c-r>=ExpandOrJump()<CR>
vnoremap <C-e> <c-r>=UltiSnips#JumpForward()<CR>
inoremap <C-e> <c-r>=UltiSnips#JumpForward()<CR>
"vmap <C-e> <TAB>
"fzf
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

nmap sleep :!pmset sleepnow<CR>

""""""
"CtrlP
"""""
nmap <leader>fzb :CtrlPBuffer<CR>
nmap <leader>fzc :CtrlPCurFile<CR>
nmap <leader>fz/ :CtrlPRoot<CR>
nmap <leader>fz. :CtrlPCurWD<CR>
nmap <leader>fzr :CtrlPMRU<CR>


lua <<EOF
function echo_sc_args()
	local lookup = vim.fn.expand("<cexpr>")
	require'scnvim'.send_silent("SCNvim.methodArgs(\"" .. lookup .. "\")")
end
EOF
"nmap <C-k> lua echo_sc_args()
