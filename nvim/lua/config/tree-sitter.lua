require("nvim-treesitter.configs").setup {
  -- ensure_installed = {"supercollider", "rust", "html", "javascript"},
  highlight = {
    enable = true,
	additional_vim_regex_highlighting = {'org'} -- Needed for orgmode
  },
  -- Enable this if you're using treesitter
  conceal = {
    enable = true,
  },ensure_installed = "supercollider",
  ignore_install = { 'org' },
  highlight = {
    enable = true, 
  --  -- additional_vim_regex_highlighting =true,
   disable = { "scnvim"},
   enable = { "supercollider"},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-t>",
      scope_incremental = "<C-t>",
      --node_incremental = "<C-y>",
      --node_decremental = "<c-Y>",
    },
  },
  indent = { enable = false},
  matchup = { enable = true },
  -- autopairs = { enable = true },
  rainbow = {
    enable =false,
    extended_mode = true, -- Highlight also non-parentheses delimiters
    max_file_lines = 1000,
  },
  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
    highlight_definitions = { enable = true },
    navigation = {
      enable =false,
      keymaps = {
        goto_definition_lsp_fallback = "gnd",
        -- use telescope for these lists
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- @TODOUA: figure out if I need both below
        goto_next_usage = "<a-*>", -- is this redundant?
        goto_previous_usage = "<a-#>", -- also this one?
      },
      -- disable = { "supercollider"},
    },
    -- highlight_current_scope = {enable = true}
  },
  textobjects = {
	  disable = { "scnvim"},
	  lsp_interop = {
		  enable = true,
		  border = "none",
		  peek_definition_code = {
			  ["df"] = "@function.outer",
			  ["dF"] = "@class.outer",
		  },
	  },
	  move = {
		  enable = true,
		  set_jumps = true, -- whether to set jumps in the jumplist
		  goto_next_start = {
			  ["]m"] = "@function.outer",
			  ["]]"] = "@call.outer",
		  },
		  goto_next_end = {
			  ["]M"] = "@function.outer",
			  ["]["] = "@call.outer",
		  },
		  goto_previous_start = {
			  ["[m"] = "@function.outer",
			  ["[["] = "@call.outer",
		  },
		  goto_previous_end = {
			  ["[M"] = "@function.outer",
			  ["[]"] = "@call.outer",
		  },
	  },
	  select = {
		  enable = true,
		  lookahead = true,
		  keymaps = {
			  ["af"] = "@function.outer",
			  ["if"] = "@function.inner",
			  ["ac"] = "@call.outer",
			  ["ic"] = "@call.inner",
		  },
	  },
	  swap = {
		  enable = true,
		  swap_next = {
			  [",a"] = "@parameter.inner",
		  },
		  swap_previous = {
			  [",A"] = "@parameter.inner",
		  },
	  },
  },
  }

