let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



let g:neosnippet#disable_runtime_snippets={'_':1,}

let g:python3_host_program='/usr/bin/python3'
call plug#begin()
" Reaper

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/nvim-treesitter-refactor'
"Plug 'nvim-treesitter/playground'
"Plug 'haorenW1025/completion-nvim'
"Plug 'nvim-treesitter/completion-treesitter'
"Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'AckslD/nvim-trevJ.lua'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'madskjeldgaard/reaper-nvim'
Plug 'madskjeldgaard/fzf-sc'

" OSC
Plug 'davidgranstrom/osc.nvim'
Plug 'preservim/nerdtree'

"Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'tzachar/cmp-tabnine'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-tags'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

Plug 'davidgranstrom/scnvim',{'do':{-> scnvim#install() } }
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/peaksea'
"Plug 'vim-scripts/bufexplorer.zip'
"Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'gcmt/taboo.vim'
Plug 'vim-scripts/utl.vim'
"Plug 'thaerkh/vim-workspace'
"Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vijaymarupudi/nvim-fzf'
"Plug 'vimwiki/vimwiki'
"Plug 'michal-h21/vim-zettel'
Plug 'Furkanzmc/zettelkasten.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'folke/which-key.nvim'
Plug 'ggandor/lightspeed.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'renerocksai/telekasten.nvim'

"Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
"Plug 'https://github.com/alok/notational-ff-vim'


"Plug 'nvim-orgmode/orgmode'
"Plug 'dhruvasagar/vim-dotoo'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

call plug#end() 


lua << EOF

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}


local home = vim.fn.expand("~/telekasten")
-- NOTE for Windows users:
-- - don't use Windows
-- - try WSL2 on Windows and pretend you're on Linux
-- - if you **must** use Windows, use "/Users/myname/zettelkasten" instead of "~/zettelkasten"
-- - NEVER use "C:\Users\myname" style paths
-- - Using `vim.fn.expand("~/zettelkasten")` should work now but mileage will vary with anything outside of finding and opening files

require('telekasten').setup({
    home         = home,

    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,

    -- dir names for special notes (absolute path or subdir name)
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- Generate note filenames. One of:
    -- "title" (default) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename = "title",
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "ivy",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "ivy",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,
})

local ls = require'luasnip'
local ls_types = require'luasnip.util.types'

ls.config.set_config {
  -- Remember last snippet
  history = true,
  -- Dynamic update
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = false,
  ext_opts = {
    [ls_types.choiceNode] = {
      active = {
        virt_text = { { '←', 'Error'} }
      }
    }
  }
}

local function expand_or_jump()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end

local function jump_back()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end

local map = vim.keymap.set


return {
  expand_or_jump = expand_or_jump,
  jump_back = jumpa_back,
}
EOF
lua << EOF
--vim.keymap.set('n','zj',function() require("trevj").format_at_cursor() end)
EOF

let mapleader = "\<SPACE>"
let maplocalleader = ','
set timeoutlen=500

set completeopt=menu,menuone,noselect
lua << EOF
local scnvim = require('scnvim')
scnvim.setup()

local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
	extensions = {
		['fzf-sc'] = {
			search_plugin = 'nvim-fzf',
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
		['zp'] = map('postwin.clear', {'n', 'i'}),
		[',fp'] = map('postwin.focus',{'n'}),
		['<C-k>'] = map('signature.show', {'n', 'i'}),
		['zz'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
		['<leader>st'] = map(scnvim.start),
		['<leader>sp'] = map(scnvim.recompile),
		['<F1>'] = map_expr('s.boot'),
		['<F2>'] = map_expr('s.meter'),
		['zx'] = map_expr('~myFree.()')
		},
	documentation = {
		cmd = '/usr/local/bin/pandoc',
		},
	postwin = {
		float = {
			enabled =true,
			callback =function(id) vim.api.nvim_win_set_option(id, 'winblend', 0) end,
			height =16
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

scnvim.load_extension('fzf-sc')

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = false;
})

--require("nvim-treesitter.configs").setup {
--  -- ensure_installed = {"supercollider", "rust", "html", "javascript"},
--  ensure_installed = "supercollider",
--  highlight = {
--    enable = true, additional_vim_regex_highlighting = true,
--    -- disable = { "supercollider"},
--  },
--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selection = "<CR>",
--      scope_incremental = "<CR>",
--      --node_incremental = "<TAB>",
--      --node_decremental = "<S-TAB>",
--    },
--  },
--  indent = { enable = true },
--  matchup = { enable = true },
--  autopairs = { enable = true },
--  playground = {
--    enable = true,
--    disable = {},
--    updatetime = 25,
--    persist_queries = false,
--    keybindings = {
--      toggle_query_editor = "o",
--      toggle_hl_groups = "i",
--      toggle_injected_languages = "t",
--      toggle_anonymous_nodes = "a",
--      toggle_language_display = "I",
--      focus_language = "f",
--      unfocus_language = "F",
--      update = "R",
--      goto_node = "<cr>",
--      show_help = "?",
--    },
--  },
--  rainbow = {
--    enable = true,
--    extended_mode = true, -- Highlight also non-parentheses delimiters
--    max_file_lines = 1000,
--  },
--  refactor = {
--    smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
--    highlight_definitions = { enable = true },
--    navigation = {
--      enable = true,
--      keymaps = {
--        goto_definition_lsp_fallback = "gnd",
--        -- use telescope for these lists
--        -- list_definitions = "gnD",
--        -- list_definitions_toc = "gO",
--        -- @TODOUA: figure out if I need both below
--        goto_next_usage = "<a-*>", -- is this redundant?
--        goto_previous_usage = "<a-#>", -- also this one?
--      },
--      disable = { "supercollider"},
--    },
--    -- highlight_current_scope = {enable = true}
--  },
--  textobjects = {
--    lsp_interop = {
--      enable = true,
--      border = "none",
--      peek_definition_code = {
--        ["df"] = "@function.outer",
--        ["dF"] = "@class.outer",
--      },
--    },
--    move = {
--      enable = true,
--      set_jumps = true, -- whether to set jumps in the jumplist
--      goto_next_start = {
--        ["]m"] = "@function.outer",
--        ["]]"] = "@call.outer",
--      },
--      goto_next_end = {
--        ["]M"] = "@function.outer",
--        ["]["] = "@call.outer",
--      },
--      goto_previous_start = {
--        ["[m"] = "@function.outer",
--        ["[["] = "@call.outer",
--      },
--      goto_previous_end = {
--        ["[M"] = "@function.outer",
--        ["[]"] = "@call.outer",
--      },
--    },
--    select = {
--      enable = true,
--      lookahead = true,
--      keymaps = {
--        ["af"] = "@function.outer",
--        ["if"] = "@function.inner",
--        ["ac"] = "@call.outer",
--        ["ic"] = "@call.inner",
--      },
--    },
--    swap = {
--      enable = true,
--      swap_next = {
--        [",a"] = "@parameter.inner",
--      },
--      swap_previous = {
--        [",A"] = "@parameter.inner",
--      },
--    },
--  },
--  }

-- David Granstrom functions
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local cmp = require'cmp'

local next_item = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local prev_item = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end
-- ------------------ 

local cmp = require'cmp'

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

 --local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local luasnip = require( "luasnip" )
local cmp = require( "cmp" )
cmp.setup {
	snippet = {
		expand = function(args)
		luasnip.lsp_expand(args.body)
		end
	},


	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		-- ["<Tab>"] = cmp.mapping(
		-- 	function(fallback)
		-- 	if cmp.visible() then
		-- 	cmp.select_next_item()
		-- else  cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
		-- 	end
		-- end,
		-- { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
		-- ),
		-- ["<S-Tab>"] = cmp.mapping(
		-- function(fallback)
		-- 	cmp_ultisnips_mappings.jump_backwards(fallback)
		-- end,
		-- { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
		-- ),

    ['<Tab>'] = cmp.mapping(next_item, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(prev_item , { 'i', 's' }),
    -- ['<C-n>'] = cmp.mapping(next_item, { 'i', 's' }),
    -- ['<C-n>'] = cmp.mapping(next_item, {'i','s'}),
    -- ['<C-p>'] = cmp.mapping(prev_item , { 'i', 's' }),

    
	},
	formatting = {
		format = function(entry, vim_item)
		vim_item.menu = ({
		tags = "[Tags]",
		path = "[Path]",
		cmp_tabnine = "[TN]",
		-- ultisnips = "[U]"
		luasnip = "[LS]"
		})[entry.source.name]
	return vim_item
end
},
	sources = {
		{ name = 'luasnip' },
		{ name = 'cmp_tabnine' },
		{ name = 'path' },
		-- { name = 'nvim_lsp' },
		{ name = 'tags' },
		-- { name = 'nvim_lua' },
		-- { name = 'treesitter' },
		-- { name = 'ultisnips' },
		-- { name = 'spell' },
		{ name = 'buffer' , keyword_length=5}, -- dont complete until at 5 chars
		},
	view = {
		entries = "native",
	},
experimental = {
	-- native_menu = true,
	ghost_text = true
	}
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

EOF
"""""""""""""""""""""""""""""""" LuaSnip

lua << EOF
require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
require("luasnip.loaders.from_lua").load({paths = "/Users/michael/.config/nvim/Luasnip"})
EOF
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
inoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
""""""""""""""""""""""""""""""""

"NOTE TAKING CRAPPP!!!
" example
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
let g:deoplete#enable_at_startup = 1

  "let g:python3_host_prog = '/usr/local/bin/python3'
" control P stuff
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
nmap <leader>fzb :CtrlPBuffer<CR>
nmap <leader>fzc :CtrlPCurFile<CR>
nmap <leader>fz/ :CtrlPRoot<CR>
nmap <leader>fz. :CtrlPCurWD<CR>
nmap <leader>fzr :CtrlPMRU<CR>


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



nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
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
