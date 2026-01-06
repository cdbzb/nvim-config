local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.supercollider then
    configs.supercollider = {
        default_config = {
            cmd = {
                "sc-language-server",
                "--log-file",
                "/tmp/sc_lsp_output.log",
                "--verbose",
                "--",
                -- "-u", "57305",
                "-l", "/Users/michael/sclang_lsp_conf.yaml",
            },
            filetypes = {'supercollider'},
            root_dir = function(fname)
                return "/"  -- you may want to improve this
            end,
            settings = {},
        }
    }
end

-- uncomment to use
-- lspconfig.supercollider.setup({})

-- local configs = require('lspconfig.configs')
--
-- configs.supercollider = {
--     default_config = {
--         cmd = {
--             "sc-language-server",
--             "--log-file",
--             "/tmp/sc_lsp_output.log",
--             "--verbose",
--             "--sclang-path /Users/michael/tank/supercollider/build/Install/SuperCollider/SuperCollider.app/Contents/MacOS/sclang",
--             "--", -- indicates the args that follow are to be passed to sclang
--             "-u", "57300",  -- e.g. custom UDP listening port for sclang
--             -- "-l", "/Users/michael/sclang_conf_lsp.yaml",  -- e.g. full path to config file
--         },
--         filetypes = {'supercollider'},
--         root_dir = function(fname)
--             return "/"
--         end,
--         settings = {},
--     },
-- }
