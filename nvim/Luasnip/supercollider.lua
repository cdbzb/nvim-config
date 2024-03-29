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
local snippets = {}

vim.api.nvim_set_keymap("i", "<C-.>", "<Plug>luasnip-next-choice", {})
ls.config.set_config({
  store_selection_keys = '<Tab>',
})

local same = function(index)
	return f(function(arg) -- return a function node!!
		return arg[1]
	end, { index } --table of stuff to pass into the outer function
	)
end
local getSection = function()
				local section = vim.api.nvim_exec([[
				call GetSectionNumber()
				]],true)
				require'scnvim'.send('Song.currentSong.getStartString(' .. section .. ')')
				return ""
			end

local date = function() return {os.date('%Y-%m-%d')} end

return {
        s({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
	s("pp",{
		t( {"[", "\t"} ),
		i(1),
		t({ "","].pp" }) 
	}),
	s({ trig="ww", snippetType= "snippet"},t".asBeats.warpTo( e.tempoMap ).q"),
	s({ trig="qq", snippetType= "snippet"},t"=> _.q"),
	
	s("play",{
		c(1,{
			sn(1,{
				t{ "[","\t" },i(1),t{ "\t","].pp" }
			}),
			sn(1,{
				t"(",i(1),t").play"
			}),
			sn(1,{
				t"{",i(1),t"}.play"
			}),
		})
	}),
	s({
		trig = "wdf",
		namr = "wrap naked degrees in square brackets.df",
		dscr = "wrap freqs in pbind"
	},
	{
		i(0),
		text({ '\"' }),
		func(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}),
		t({"\".df(\\" }), i(1), text({")"}),
		i(2),
	}),
	s({
		trig = "wrapp",
		namr = "wrap freqs in pbind",
		dscr = "wrap freqs in pbind"
	},
	{
		text({ '[',"\t" }),
		i(1),
		func(function(_, snip)
			return string.gsub(snip.env.TM_SELECTED_TEXT[1],"_","i")
		end, {}),
		i(2),
		text({"", '].pp' }),
		i(0),
	}),
	s("func",{
		t("{ |i| "),
		func(function(_, snip)
			return string.gsub(snip.env.TM_SELECTED_TEXT[1],"_","i")
		end, {}),
		i(1),
		t("}")
	}),
	s("Play",
	fmt([[
	{{
	{}
	}}.play;
	]],{
		f(function(_, snip)
			-- return snip.env.TM_SELECTED_TEXT or {}
			local res, env = {}, snip.env
			for _, ele in ipairs(env.LS_SELECT_RAW) do table.insert(res, ele) end
			return res

		end,{}
		)
	})
	),
	s("still",{
		t("P.still(\\"),
		i(1,"name:"),
		t(", timecode: "),
		i(2),
		t({ ".seconds, music: { |p b e|",
			"\t e.still.( ",
			"\t\twait: " })
			,i(3),
			c(4, { --table of choices
				{ t( {"","\t\ttext: [\""} ), i(1), t{[[","]]}, i(2), t{"\"],"} },
				{ t( { ",","\t\tfade: " } ), i(1), t{","}},
				t{""}

			}) ,
			t({
				"",
				"\t)",
			}),
			i(0),
			t({
				"",
				"});"
			})
	}),
	s("tune", {
		t'P.tune(\\' ,
	sn(1,{
			f(function(_,parent)
				local section = vim.api.nvim_exec([[
				call GetSectionNumber()
				]],true)
				require'scnvim'.send('Song.currentSong.getStartString(' .. section .. ')')
				return ""
			end,{}
			),
			i(1)
		}),

		i(2),t(");"),i(0)
	}),
	postfix(".pp", {
		f(function(_, parent)
			return "[" .. parent.snippet.env.POSTFIX_MATCH .. ":"
		end, {}),
		i(1),t',].pp'

	}),
	s("env",
		fmt("{}{}({}).kr({},gate:{})",{
			c( 1, {
				t("Env."),
				t("* Env."),
				t("Env")
			}), i(2),i(3),i(4,"2"),c(5, {
				i(1,"1"),
				t("\\gate.kr(1)")
			})
		})
	),
	s("mega",
		fmt([[
		MegaBind(
			[
				[{}]
			]
			,
			{},
			[{}],
			{},
			{}
		)
		]],{
			i(1,"notes"),
			i(2,"durs"),
			i(3,"bind"),
			sn(4,{ t("{|i| "),i(1," SinOsc.ar(i.freqSeq,0,0.1)"),t("}") }),
			sn(5,{ t("{|i| "),i(1," Mix.ar(i)"),t("}") }),
		})
	
	),
	s("synthV",
		fmt([[
			P.synthV({}, take: \lead, params: {{|p b| [
				lyrics: "{}",
				pitchTake: 1
			] }}, music:{{|p b e|
				{{
					e.playbuf
					=> p.synthVTracks.at(e.key).()
				}}.play
			}});
		]],{
			i(1,"voice - start"),i(2)
		})
	),
	s({ trig = 'role.(%a*)',regTrig=true, name=' synthv for role' },
		fmt([[
			P.synthV(role: \{}, take: \lead, params: {{|p b| [
				lyrics: "{}",
				pitchTake: 1
			] }}, music:{{|p b e|
				{{
					e.playbuf
					=> p.synthVTracks.at(e.key).()
				}}.play

			}});
		]],{
			f( function(_,snip) return snip.captures[1] end ),
			-- i(1,"voice - start"),
			i(1)
		})
		
	),
	s({trig = '(%a*)(.part)', regTrig=true, name='part regex',snippetType="snippet" },
		fmt([[
			P(\{}, music: {{ |p b e|
				{}
			}});
		]],{
			f( function(_, snip) return snip.captures[1] end ),
			i(1,"")
		})
	),
	s("double",
		fmt([[
			P.double({}, take: {}, params: {{|p b| [
				{}
			] }}, music:{{|p b e|
				{{
					e.playbuf
					=> p.synthVTracks.at(e.key).()
				}}.play
			}});
		]],{
			i(1,"voice - start"),i(2, "\\lead"),i(3)
		})
		
	),
	s("synthvdouble",
	fmt([[
		P.synthV({}, take:\lead, params: {{|p b| [
			lyrics: "{}",
			pitchTake: 1
		] }}, music:{{|p b e|
			{{
				e.playbuf
				=> p.synthVTracks.at(e.key).()
			}}.play
		}});
		P.double({}, params: {{|p b| [
				{}
			] }}, music:{{|p b e|
				{{
					e.playbuf
					=> p.synthVTracks.at(e.key).()
				}}.play
			}});
]],{
		i(1,"voice - start"),i(2),f(function(args, snip) return args[1] end, {1}),i(3)
	})
	
	),
	s("filter", 
	fmt([[ filter: ({}{}), ]],
	{ i(1, "midinote:"), i(2, " _ - 12") }
		)
	),
	s("start",{
		t"start: \\",
		f(function(_,parent)
			local section = vim.api.nvim_exec([[
			call GetSectionNumber()
			]],true)
			require'scnvim'.send('Song.currentSong.getStartString(' .. section .. ')')
			return ""
		end,{}
		)
	}),
}
		



