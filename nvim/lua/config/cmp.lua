
-- David Granstrom functions
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local cmp = require'cmp'

local next_item = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  --elseif has_words_before() then
  --  cmp.complete()
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
		['<C-n>'] = cmp.mapping.complete({
			config = {
				sources = {
					{ name = 'luasnip' }
				}
			}
		}),
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
		{ name = 'treesitter' },
		-- { name = 'ultisnips' },
		-- { name = 'spell' },
		{ name = 'buffer' , keyword_length=5}, -- dont complete until at 5 chars
		},
	view = {
		entries = "native",
	},
experimental = {
	-- native_menu = true,
	-- ghost_text = true
	}
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

