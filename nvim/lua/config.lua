local set = vim.opt
vim.g.python3_host_program ='/usr/bin/python3'
vim.g.mapleader = " "
vim.g.maplocalleader = ','

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'  -- conceals in normal and command mode

require('config.songFunctions')
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
	{ "rebelot/kanagawa.nvim", lazy = true},
	{
		'nvim-orgmode/orgmode',
		event = 'VeryLazy',
		ft = { 'org' },
		config = function()
			-- Setup orgmode
			require('config.orgmode')

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
				--   ensure_installed = 'all',
				--   ignore_install = { 'org' },
				-- })
		end,
	},
	{
		"chipsenkbeil/org-roam.nvim",
		tag = "0.1.1",
		dependencies = {
			{
				"nvim-orgmode/orgmode",
				tag = "0.3.7",
			},
		},
		config = function()
			require("org-roam").setup({
				directory = "~/org_roam_files",
				-- optional
				org_files = {
					"~/tank/org/*.org",
				}
			})
		end
	},
	{
		'stevearc/oil.nvim',
		opts = {},
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{"nvim-tree/nvim-tree.lua", opts={}},
	-- { "ThePrimeagen/harpoon", branch = "harpoon2" },
	"mhinz/vim-startify",
	'tpope/vim-surround',
	 {"numToStr/Comment.nvim", opts = {}}, 
	{ "L3MON4D3/LuaSnip", 
	event = "VeryLazy",
	opts = {},
	-- lazy =true,
	-- config = function() 
	-- 		require("config.luasnip")
	-- 	end,
	}
	,
	{ 
		"hrsh7th/nvim-cmp", lazy = false, dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"quangnguyen30192/cmp-nvim-tags",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip"
		}, config = function()
			require("config.cmp")
		end
	},
	{
		"davidgranstrom/scnvim", lazy = false, dependencies = {
			"davidgranstrom/osc.nvim",
			"cdbzb/scnvim-logger",
			"madskjeldgaard/reaper-nvim",
		},
		config = function()
			require("config.scnvim")
		end
	},

	{"akinsho/toggleterm.nvim", opts={}},

	"junegunn/vim-easy-align",
	-- "ggandor/lightspeed.nvim",
	{"ggandor/leap.nvim", config = 
		function()
		require('leap').add_default_mappings() --s S
		require('leap').init_highlight(true)
	end
	}, 
	{
		"folke/which-key.nvim", lazy = false,
		config = function()
			require("config.which-key")
		end
	},

	"BurntSushi/ripgrep",
	{
		"nvim-telescope/telescope.nvim", opts={},
		dependencies = {
			"madskjeldgaard/telescope-supercollider.nvim",
			"davidgranstrom/telescope-scdoc.nvim",
			"nvim-lua/plenary.nvim",
		},
	}, 
	-- 'nvim-telescope/telescope-media-files.nvim',

	{
		'nvim-treesitter/nvim-treesitter',  build= ":TSUpdate", opts = {}, dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-refactor",
			-- "nvim-treesitter/completion-treesitter",
		}, config = function()
			require'config.tree-sitter'
		end
	},
	-- "haorenW1025/completion-nvim",
	-- "jiangmiao/auto-pairs", 
	 {"neovim/nvim-lspconfig", enable = false},
	-- "Furkanzmc/zettelkasten.nvim",
	"nvim-lua/popup.nvim",
	"vijaymarupudi/nvim-fzf",
	{"madskjeldgaard/fzf-sc", enable = false},
	-- {"junegunn/fzf",  build =   ": call fzf#install()" },
	-- "junegunn/fzf.vim",
	{"echasnovski/mini.splitjoin", opts = {}},
	{'echasnovski/mini.bufremove', version = false, opts = {} },
	-- "akinsho/bufferline.nvim" 
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


-- require'config.luasnip'
-- require'lspconfig'.marksman.setup{}
vim.cmd([[colorscheme peaksea
" set gfn=Menlo:h21
set background=dark
colorscheme peaksea
set termguicolors
color kanagawa]])

set.timeoutlen=500
set.completeopt=menu,menuone,noselect

-- require('leap').add_default_mappings() --s S
-- require('leap').init_highlight(true)
-- require("config.bufferline")
-- require("config.telekasten")
-- require'glow'.setup()
function search_string(str)
  local match_pos = vim.fn.search(str)
  if match_pos ~= 0 then
    -- Found a match, move the cursor to the position
    vim.api.nvim_win_set_cursor(0, {match_pos, 0})
  else
    print("String not found: " .. str)
  end
end


-- autocmds


local api=vim.api
-- api.nvim_create_autocmd(
--   "FileType", {
-- 		pattern = { "SuperCollider" }, command = [[silent! lua require('scnvim').start()]] 
-- 	}
-- )
api.nvim_create_autocmd(
	"bufenter", {
		pattern = { "*.org" },
		command = ":set foldexpr=nvim_treesitter#<cr>",
		command = ":setlocal foldtext=getline(v:foldstart)"
	}
)
api.nvim_create_autocmd(
	"bufenter", {
		pattern = { "*.sc" },
		command = ":set foldexpr=nvim_treesitter#<cr>"
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
"Filetype", { pattern = { "SuperCollider" },command = [[ lua require'config.luasnip' ]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "SuperCollider" },command = [[ lua require'reaper-nvim'.setup() ]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "markdown" },command = [[lua require('cmp').setup.buffer { enabled = false }]] }
)



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



	-- vim.cmd([[
	-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
	-- " -1 for jumping backwards.
	-- inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
	-- snoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
	-- inoremap <silent> <c-n> <cmd>lua require('luasnip').jump(1)<Cr>
	-- snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
	--
	-- smap hh <c-o>2b
	-- map <leader>mul <ESC>:s/, mul:1.0, add:0.0//<CR>
	--
	-- " For changing choices in choiceNodes (not strictly necessary for a basic setup).
	-- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
	-- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
	-- ]])
