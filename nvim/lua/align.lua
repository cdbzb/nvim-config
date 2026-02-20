_G.AlignTopLevelCommas = function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  vim.api.nvim_exec2(string.format([[
    %d,%ds/\[\zs[^\]]*\]/\=substitute(submatch(0), ",", "␞", "g")/ge
    %d,%dEasyAlign *,
    %d,%ds/␞/,/ge
  ]], start_line, end_line, start_line, end_line, start_line, end_line), {})
end

vim.keymap.set("x", "<Leader>a,", ":lua AlignTopLevelCommas()<CR>", { silent = true })
