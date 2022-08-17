local ls = require'luasnip'
local ls_types = require'luasnip.util.types'

require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
require("luasnip.loaders.from_lua").load({paths = "/Users/michael/.config/nvim/Luasnip"})

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


