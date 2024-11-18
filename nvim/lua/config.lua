local set = vim.opt
vim.g.python3_host_program ='/usr/bin/python3'
vim.g.mapleader = " "
vim.g.maplocalleader = ','


--  lazy-nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options

require("lazy").setup({
	{
		'stevearc/oil.nvim',
		opts = {},
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"nvim-tree/nvim-tree.lua",
	-- { "ThePrimeagen/harpoon", branch = "harpoon2" },
	"mhinz/vim-startify",
	'tpope/vim-surround',
	"numToStr/Comment.nvim", 
	"rebelot/kanagawa.nvim",
	{ "L3MON4D3/LuaSnip", 
	event = "VeryLazy",
	-- lazy =true,
	-- config = function() 
	-- 	require("config.luasnip")
	-- end,
	}
	,
	{ "hrsh7th/nvim-cmp", lazy = true},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	-- "tzachar/cmp-tabnine",
	{ "davidgranstrom/scnvim", lazy = false},
	"cdbzb/scnvim-logger",

	"madskjeldgaard/reaper-nvim",
	"akinsho/toggleterm.nvim",

	"junegunn/vim-easy-align",
	-- "ggandor/lightspeed.nvim",
	"ggandor/leap.nvim",
	{"folke/which-key.nvim", lazy = true },

	"nvim-lua/plenary.nvim",
	"BurntSushi/ripgrep",
	"nvim-telescope/telescope.nvim", 
	-- 'nvim-telescope/telescope-media-files.nvim',
	"madskjeldgaard/telescope-supercollider.nvim",
	"davidgranstrom/telescope-scdoc.nvim",


	{ 'nvim-treesitter/nvim-treesitter',  build= ":TSUpdate" },
	-- "nvim-treesitter/completion-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-refactor",

	-- "haorenW1025/completion-nvim",
	"quangnguyen30192/cmp-nvim-tags",

	"jiangmiao/auto-pairs",
	"davidgranstrom/osc.nvim",
	"neovim/nvim-lspconfig",
	-- "Furkanzmc/zettelkasten.nvim",
	"nvim-lua/popup.nvim",
	"vijaymarupudi/nvim-fzf",
	"madskjeldgaard/fzf-sc",
	-- {"junegunn/fzf",  build =   ": call fzf#install()" },
	-- "junegunn/fzf.vim",

	"echasnovski/mini.splitjoin",
	-- "akinsho/bufferline.nvim" 
	--
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			-- refer to `configuration to change defaults`
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
},
})
require'lspconfig'.marksman.setup{}

vim.cmd([[colorscheme peaksea
" set gfn=Menlo:h21
set background=dark
colorscheme peaksea
set termguicolors
color kanagawa]])

set.timeoutlen=500
set.completeopt=menu,menuone,noselect

require('leap').add_default_mappings() --s S
require('leap').init_highlight(true)
require("nvim-tree").setup()
require("oil").setup()
-- require("config.bufferline")
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
-- require'glow'.setup()
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

local api=vim.api
-- api.nvim_create_autocmd(
--   "FileType", {
-- 		pattern = { "SuperCollider" }, command = [[silent! lua require('scnvim').start()]] 
-- 	}
-- )
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
"Filetype", { pattern = { "SuperCollider" },command = [[ lua require'reaper-nvim'.setup() ]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "markdown" },command = [[lua require('cmp').setup.buffer { enabled = false }]] }
)

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
