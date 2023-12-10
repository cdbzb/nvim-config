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
	s({ trig="qq", snippettype= "snippet"},t"=> _.q"),
	s({ trig="df", snippettype= "snippet"},{ t".df('",i(1),t"')" }),
	
	s({ trig="vo" },
		fmt([[
			P.synthV(role: \vocoder, take: \lead, params: {{|p b| [
				lyrics: "{}",
				pitchTake: 1
			] }}, music:{{|p b e|
				p.vocodeTune.(p, b, e, e.rpp,
					dur: {},
					att: {},
					sus: {},
					rel: {}
				)

			}});
		]],{
			i(1),
			i(2,"b.sum"),
			i(3,"0.2"),
			i(4, "b.sum - 0.2"),
			i(5, "1")
		})
		
	),
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
	},{
		i(0),
		text({ '\"' }),
		func(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}),
		t({"\".df(\\" }), i(1), text({")"}),
		i(2),
	}),
	s({
		trig = "fx"
	},fmt([[
	Effect.bus({{|i| {} }},{})
	]],{
		i(1),i(2)
	})
	),
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
	s("clear",{
		t("P.still(\\"),
		i(1,"clear"),
		t(", timecode: "),
		t({ "0.seconds, music: { |p b e|",
			"\t e.still.( ",
			"\t\twait: " })
			,i(2, "b.sum"),
			c(3, { --table of choices
				{ t( {",","\t\ttext: [\""} ), i(1), t{[[","]]}, i(2), t{"\"],"} },
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
	s("still",{
		t("P.still(\\"),
		i(1,"name:"),
		t(", timecode: "),
		i(2),
		t({ ".seconds, music: { |p b e|",
			"\t e.still.( ",
			"\t\twait: " })
			,i(3, "b.sum"),
			c(4, { --table of choices
				{ t( {",","\t\ttext: [\""} ), i(1), t{[[","]]}, i(2), t{"\"],"} },
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
		).play
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
	s("panned",
		fmt([[
			{{
				var pan = [-1, 1];
				2.collect {{|i|
					{{|p b e|
						{{
							e.playbuf
							// => p.synthVTracks.at(e.key).()
							=> Pan2.ar(_,pan[i])
							{}
						}}.play
					}}
				}}
				}}.()
			]],{
				i(1)
				})
	),
	s("pan",
		fmt([[
			=> Pan2.ar(_, {})
			]],{
				i(1, "0")
				})
	),
	s({ trig = 'rr',regTrig=true, name = 'rhythm recorder' },
		fmt([[
			Song.rhythmRecorder( {} );
		]],
		{ i(1, "2") }
		)
	),
	s({ trig = 'double.(%a*)',regTrig=true, name=' synthv for role' },
		fmt([[
			P.double(role: \{}, take: \lead, params: {{|p b| [
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
	s({trig='tpm'},{t"Song.setTempoMap(\\",i(1),t',"', i(2),t'");'}),
	s({trig='=.'},{ t'=> _.' }),
	s({trig='sqt'},
		fmt([[
			.sequenceText2(
					b.parse([{}]), [ 
					["{}","{}"],{}
					],
			)
		]],{ i(1, "wait"), i(2), i(3),i(4) })
	),
	s({trig='bp'},{
		t'b.parse([',i(1), t'])'
	}),
	s({trig = '(%a*)(.part)', regTrig=true, hidden=true, name='part regex',snippetType="snippet" },
		fmt([[
			P(\{}, music: {{ |p b e|
				{}
			}});
		]],{
			f( function(_, snip) return snip.captures[1] end ),
			i(1,"")
		})
	),
	s("boil",
	t"\"~/tank/super/Trek/Songs/boilerplate.scd\".standardizePath.load;"
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
	s("filter", fmt([[ filter: ({}{}), ]],
		{ i(1, "midinote:"), i(2, " _ - 12") }
	)),
	s("legato", fmt([[legato: [{},{} ],]],
		{ i(1), i(0) }
	)),
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
		



