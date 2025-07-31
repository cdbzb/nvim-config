vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "kanagawa",
  callback = function()
    local palette = require("kanagawa.colors").setup()

    -- vim.api.nvim_set_hl(0, "@neorg.headings.1.title.norg", { fg = palette.theme.syn.constant, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.2.title.norg", { fg = palette.theme.syn.statement, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.3.title.norg", { fg = palette.theme.syn.identifier, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.4.title.norg", { fg = palette.theme.syn.preproc, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.5.title.norg", { fg = palette.theme.syn.special, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.6.title.norg", { fg = palette.theme.syn.type, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.1.prefix", { fg = palette.theme.syn.constant, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.2.prefix", { fg = palette.theme.syn.statement, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.3.prefix", { fg = palette.theme.syn.identifier, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.4.prefix", { fg = palette.theme.syn.preproc, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.5.prefix", { fg = palette.theme.syn.special, bold = true })
    -- vim.api.nvim_set_hl(0, "@neorg.headings.6.prefix", { fg = palette.theme.syn.type, bold = true })
-- local palette = require("kanagawa.colors").setup().palette

-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet1", { fg = palette.surimiOrange })
-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet2", { fg = palette.crystalBlue })
-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet3", { fg = palette.springViolet1 })
-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet4", { fg = palette.waveRed })
-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet5", { fg = palette.dragonBlue })
-- vim.api.nvim_set_hl(0, "NeorgHeadingBullet6", { fg = palette.springGreen })

  end,
})

-- Load the theme (you can also put this earlier)
vim.cmd.colorscheme("kanagawa")

