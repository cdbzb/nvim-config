local set = vim.opt
vim.g.python3_host_program ='/usr/bin/python3'
vim.g.mapleader = " "
vim.g.maplocalleader = ','

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'  -- conceals in normal and command mode
vim.o.shell = '/bin/bash'

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
	{ "rebelot/kanagawa.nvim", lazy = 'VeryLazy'},
{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 
	-- 'default'
	-- 'super-tab'
	'enter'
},

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path','snippets', 'buffer' },
    },
      snippets = { preset = 'luasnip' },
    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
  },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  opts_extend = { "sources.default" }
},
{
    'MeanderingProgrammer/render-markdown.nvim',
	enbaled = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}
    ,
	{
		"nvim-neorg/neorg-telescope",
		enabled=false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-neorg/neorg",
		}
	},
	{
		"nvim-neorg/neorg",
		enabled=false,
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		dependencies = {"vhyrro/luarocks.nvim", priority=1000, config=true},
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.summary"] = {},
					["core.integrations.treesitter"] = {},
					["core.completion"] = {config = {engine = "nvim-cmp"}},
					["core.integrations.telescope"] = {
						config = {
							insert_file_link = {
								-- Whether to show the title preview in telescope. Affects performance with a large
								-- number of files.
								show_title_preview = true,
							},
						}
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
					["core.keybinds"] = {
						config = {
							neorg_leader = "<Leader>o", -- or whatever your leader is
							hook = function(keybinds)
								keybinds.remap_event("norg", "i", "<M-CR>", "core.itero.next-iteration") -- remove default
								keybinds.remap_event("norg", "i", "<M-CR>", "core.itero.next-iteration") -- remove default

								-- Set your new keybinding
								keybinds.map_event("norg", "i", ",o", "core.itero.next-iteration")
							end
						}
					}
				},
			}

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
			-- require('config.colors') -- loads neorg colors
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua",              -- optional
			"echasnovski/mini.pick",         -- optional
		},
		config = true
	},
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
		"nvim-orgmode/telescope-orgmode.nvim",
		-- event = "VeryLazy",
		dependencies = {
			"nvim-orgmode/orgmode",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("orgmode")

		end,
	},
-- Lua
{
  "folke/twilight.nvim",
  opts = {
	  context = 5,
	  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
	      "constant", --level2 in org
	      "statement", --level3
	      "function",
	      "method",
	      "table",
	      "if_statement",
  },
  }
},
"junegunn/limelight.vim",
"junegunn/goyo.vim",
"folke/zen-mode.nvim",
	{
		"chipsenkbeil/org-roam.nvim",
		enabled=false,
		tag = "0.1.1",
		dependencies = {
			{
				"nvim-orgmode/orgmode",
				-- tag = "0.3.7",
			},
		},
		config = function()
			require("org-roam").setup({
				directory = "~/tank/org_roam_files",
				-- optional
				org_files = {
					"~/tank/org/*.org",
					"~/tank/org_roam_files/*.org"
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
	dependencies = {"cdbzb/scnvim"},
	-- lazy =true,
	-- config = function() 
	-- 		require("config.luasnip")
	-- 	end,
	}
	,
	{ 
		"hrsh7th/nvim-cmp", lazy = false,
		enabled = false,
		dependencies = {
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
		"cdbzb/scnvim", lazy = false, dependencies = {
			"davidgranstrom/osc.nvim",
			"cdbzb/scnvim-logger",
			"madskjeldgaard/reaper-nvim",
		},
		branch = "main",
		config = function()
			require("config.scnvim")
		end
	},

	{"akinsho/toggleterm.nvim", opts={}},
	-- {"kassio/neoterm", opts={}},

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
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
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
-- Ensure LuaSnip recognizes the filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "supercollider",
  callback = function()
    require("luasnip").filetype_extend("supercollider", {"supercollider"})
  end,
})

-- Make sure you have ripgrep installed.
-- Add the following function to your `~/.config/nvim/init.lua`:
-- do
--     local _, neorg = pcall(require, "neorg.core")
--     local dirman = neorg.modules.get_module("core.dirman")
--     local function get_todos(fallback_dir, states)
--         local current_workspace = dirman.get_current_workspace()
--         -- Extract the path string from the workspace info
--         local workspace_path = current_workspace and current_workspace[2] or fallback_dir
--         
--         -- Ensure we have a string path, not a table
--         local dir_path = type(workspace_path) == "string" and workspace_path or fallback_dir
--         
--         require('telescope.builtin').live_grep{ cwd = dir_path }
--         vim.fn.feedkeys('^ *([*]+|[-]+) +[(]' .. states .. '[)]')
--     end
--     -- This can be bound to a key
--     vim.keymap.set('n', '<leader>at', function() get_todos('~/notes', '[^x_]') end)
-- end
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
--from claude
api.nvim_create_autocmd("FileType", {
  pattern = "supercollider",
  callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
  end,
})
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
"Filetype", { pattern = { "org" },command = [[ lua require'config.luasnip' ]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "SuperCollider" },command = [[ lua require'reaper-nvim'.setup() ]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "markdown" },command = [[lua require('cmp').setup.buffer { enabled = false }]] }
)
api.nvim_create_autocmd(
"Filetype", { pattern = { "org" },command = [[let b:surround_45 = "#+BEGIN_SRC supercollider \n \r \n #+END_SRC"]] }
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
-- from Claude to handle indentation with spaces in code blocks:
-- vim.api.nvim_create_autocmd("FileType", {




-- In your init.lua or a file sourced by it, after loading kanagawa
--- Get Kanagawa colors and apply to Neorg headings

-- If you need to be more specific, you can try:
-- vim.api.nvim_set_hl(0, 'NeorgHeadings.3.title', { fg = '#A7C08F', bold = true })

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
