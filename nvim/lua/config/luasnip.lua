local ls = require'luasnip'
local ls_types = require("luasnip.util.types")

-- vim.keymap.set({"i", "s"}, "<Tab>", function()
--     if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--     end
-- end, { silent = true })

vim.keymap.set({"i", "s"}, "<Tab>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    else
        -- Fallback to normal Tab behavior
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    end
end, { silent = true })

require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
-- require("luasnip").add_snippets("org")

-- require'luasnip'.add_snippets(
-- 	'supercollider',
-- 	 require'scnvim.utils'.get_snippets()
-- )
require("luasnip.loaders.from_lua").lazy_load({paths = "/Users/michael/.config/nvim/Luasnip"})
require("luasnip.loaders.from_lua").lazy_load({paths = "/Users/michael/.config/nvim/scnvim/SCNvim_snippets.lua"})

ls.config.set_config {
  -- Remember last snippet
  history = false,
  -- Dynamic update
  -- updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
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

-- local map = vim.keymap.set


return {
  expand_or_jump = expand_or_jump,
  jump_back = jump_back,
}



