local set = vim.opt
vim.g.python3_host_program ='/usr/bin/python3'


vim.g.mapleader = " "
vim.g.maplocalleader = ','

set.timeoutlen=500
set.completeopt=menu,menuone,noselect

vim.cmd( [[
call plug#begin()
" Reaper

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'
"Plug 'haorenW1025/completion-nvim'
Plug 'nvim-treesitter/completion-treesitter'
"Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ray-x/cmp-treesitter'

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

"Plug 'jghauser/follow-md-links.nvim'
Plug 'Preservim/vim-markdown'

"Plug 'nvim-orgmode/orgmode'
"Plug 'dhruvasagar/vim-dotoo'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'github/copilot.vim'
call plug#end() 
]])

require("config.telescope")
require("config.telekasten")
require("config.luasnip")
require("config.scnvim")
-- require("config.tree-sitter")
require("config.cmp")
require("config.which-key")


vim.cmd([[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
inoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

local api=vim.api
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "SuperCollider" }, command = [[silent! lua require('scnvim').start()]] }
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
