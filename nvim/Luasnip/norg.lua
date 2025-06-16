local ls = require("luasnip")
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


-- local date = function() return {os.date('%Y-%m-%d')} end
local date = function() return {os.date("%b %d, %Y")} end
return {
	s({
		trig = "date",
		name = "Date",
		dscr = "Date in the form of Jun 6, 2025",
	}, {
		func(date, {}),
	}),
s({
        trig = "cd",
        name = "sc code block v3", 
        dscr = "sc code block with proper indentation"
    }, {
        t({"@code supercollider", ""}),
        i(1, "// your code here"),
		t({"", "@end"}),
	})
}
