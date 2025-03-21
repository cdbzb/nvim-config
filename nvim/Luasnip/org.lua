local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local s = ls.snippet
local sn = ls.snippet_node
local text = ls.text_node
local t = ls.text_node
local insert = ls.insert_node
local i = ls.insert_node
local func = ls.function_node
local f = ls.function_node
local choice = ls.choice_node
local c = ls.choice_node
local dynamicn = ls.dynamic_node
local postfix = require("luasnip.extras.postfix").postfix
local fmt = require("luasnip.extras.fmt").fmt

return {
	s({ trig="src", snippetType= "snippet"}, fmt([[
	#+BEGIN_SRC supercollider
	{}
	#+END_SRC
	]], 
	 i(1) 
	)
	)
}
