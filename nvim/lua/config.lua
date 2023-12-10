local set = vim.opt
vim.g.python3_host_program ='/usr/bin/python3'


vim.g.mapleader = " "
vim.g.maplocalleader = ','

set.timeoutlen=500
set.completeopt=menu,menuone,noselect
vim.cmd([[
call plug#begin()
" Reaper
Plug	'mhinz/vim-startify',
Plug	'numToStr/Comment.nvim', 
Plug	'akinsho/toggleterm.nvim',
Plug	'p00f/nvim-ts-rainbow',
Plug	'savq/melange',
Plug	'fenetikm/falcon',
Plug	'rebelot/kanagawa.nvim',
Plug	'mhartington/oceanic-next',
Plug	'jiangmiao/auto-pairs',
Plug	'vim-scripts/peaksea',
Plug	'tpope/vim-surround',
Plug 'akinsho/bufferline.nvim' , { 'tag': 'v3.*' }
Plug 'projekt0n/github-nvim-theme'
Plug 'ishan9299/nvim-solarized-lua'

Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ellisonleao/glow.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
"Plug 'nvim-treesitter/playground'

Plug 'haorenW1025/completion-nvim'

Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'bennypowers/splitjoin.nvim'
Plug 'echasnovski/mini.splitjoin'
Plug 'AckslD/nvim-trevJ.lua'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'madskjeldgaard/reaper-nvim'
Plug 'madskjeldgaard/fzf-sc'
Plug 'madskjeldgaard/telescope-supercollider.nvim'
Plug 'davidgranstrom/telescope-scdoc.nvim'

" OSC
Plug 'davidgranstrom/osc.nvim'
Plug 'preservim/nerdtree'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'tzachar/cmp-tabnine'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-tags'

Plug 'davidgranstrom/scnvim',{'do':{-> scnvim#install() } }

Plug 'gcmt/taboo.vim'
Plug 'vim-scripts/utl.vim'
Plug 'xolox/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'Furkanzmc/zettelkasten.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'folke/which-key.nvim'
Plug 'ggandor/lightspeed.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'Preservim/vim-markdown'

call plug#end() 
]])

require("config.bufferline")
require("toggleterm").setup{}
require("config.telescope")
require'telescope'.load_extension('scdoc')
require('Comment').setup()
-- require("config.telekasten")
require("config.luasnip")
require("config.scnvim")
require("config.tree-sitter")
require("config.cmp")
require("config.which-key")
require'glow'.setup()
require('mini.splitjoin').setup()
function search_string(str)
  local match_pos = vim.fn.search(str)
  if match_pos ~= 0 then
    -- Found a match, move the cursor to the position
    vim.api.nvim_win_set_cursor(0, {match_pos, 0})
  else
    print("String not found: " .. str)
  end
end


vim.cmd([[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
inoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

smap hh <c-o>2b
map <leader>mul <ESC>:s/, mul:1.0, add:0.0//<CR>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

local api=vim.api
api.nvim_create_autocmd(
  "FileType", {
		pattern = { "SuperCollider" }, command = [[silent! lua require('scnvim').start()]] 
	}
)
api.nvim_create_autocmd(
	"BufEnter", {
		pattern = { "*.sc" },
		command = ":set foldexpr=nvim_treesitter#<CR>"
	}
)
api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" }, {
		pattern = { "*.sc", "*.scd" },
		command = ":set tabstop=4"
	}
)
api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" }, {
		pattern = { "*.sc", "*.scd" },
		command = ":set shiftwidth=4"
	}
)
api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" }, {
		pattern = { "*.sc", "*.scd" },
		command = ":set softtabstop=4"
	}
)
api.nvim_create_autocmd(
	{ "BufEnter", "BufNewFile" }, {
		pattern = { "*.sc", "*.scd" },
		command = ":set noexpandtab"
	}
)
api.nvim_create_autocmd(
"Filetype ", { pattern = { "SuperCollider" },command = [[ lua require'reaper-nvim'.setup() ]] }
)
api.nvim_create_autocmd(
"Filetype ", { pattern = { "markdown" },command = [[lua require('cmp').setup.buffer { enabled = false }]] }
)

vim.cmd([[
au User GoyoEnter Limelight
]])

vim.cmd([[
au User GoyoLeave Limelight!
]])

local status, bufferline = pcall(require, "bufferline")
if not status then
  print("ERROR bufferline")
  return
end
bufferline.setup{
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
	    numbers = "ordinal",
            custom_filter = function(buf_number, buf_numbers)
                if vim.fn.bufname(buf_number) ~= "" then
                    return true
                end
            end,
        }
}
