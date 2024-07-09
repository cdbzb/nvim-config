-- define the function to count occurrences
function songSections()
  local count = 0
  for _ in string.gmatch(vim.api.nvim_buf_get_lines(0, 0, -1, false), 'addLine') do
    count = count + 1
  end
  return count
end

