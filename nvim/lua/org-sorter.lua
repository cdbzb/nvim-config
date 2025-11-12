-- Org-mode heading sorter by date
-- Place this in your Neovim config or a plugin file

local M = {}

-- Extract date from heading text like "** Oct 30, 2025"
local function extract_date(text)
  -- Match pattern: ** Month Day, Year
  local month_names = {
    Jan = "01", Feb = "02", Mar = "03", Apr = "04",
    May = "05", Jun = "06", Jul = "07", Aug = "08",
    Sep = "09", Oct = "10", Nov = "11", Dec = "12"
  }
  
  -- Remove stars and TODO keywords
  local cleaned = text:gsub("^%*+%s+", ""):gsub("^TODO%s+", ""):gsub("^DONE%s+", "")
  
  -- Match "Month Day, Year" format
  local month_str, day, year = cleaned:match("^(%a+)%s+(%d+),%s+(%d%d%d%d)")
  
  if month_str and day and year then
    local month = month_names[month_str]
    if month then
      return string.format("%s-%s-%02d", year, month, tonumber(day))
    end
  end
  
  return nil
end

-- Parse org buffer into heading groups
local function parse_headings(lines, start_line, end_line)
  local headings = {}
  local current = nil
  
  for i = start_line, end_line do
    local line = lines[i]
    local stars = line:match("^(%*+)%s")
    
    if stars then
      if current then
        table.insert(headings, current)
      end
      current = {
        level = #stars,
        start_line = i,
        lines = {line},
        date = extract_date(line)  -- Extract date from heading itself
      }
    elseif current then
      table.insert(current.lines, line)
    end
  end
  
  if current then
    table.insert(headings, current)
  end
  
  return headings
end

-- Sort headings by date
function M.sort_by_date()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  
  -- Get visual selection or use whole buffer
  local start_line, end_line
  local mode = vim.fn.mode()
  
  if mode == 'V' or mode == 'v' or mode == '\22' then -- visual mode
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  else
    start_line = 1
    end_line = #lines
  end
  
  -- Parse headings
  local headings = parse_headings(lines, start_line, end_line)
  
  if #headings == 0 then
    print("No headings found to sort")
    return
  end
  
  -- Find the minimum level to determine what to sort
  local min_level = math.huge
  for _, h in ipairs(headings) do
    min_level = math.min(min_level, h.level)
  end
  
  -- Group headings by parent level
  local groups = {}
  local current_group = {}
  
  for _, heading in ipairs(headings) do
    if heading.level == min_level then
      if #current_group > 0 then
        table.insert(groups, current_group)
      end
      current_group = {heading}
    else
      table.insert(current_group, heading)
    end
  end
  if #current_group > 0 then
    table.insert(groups, current_group)
  end
  
  -- Sort each group by date
  table.sort(groups, function(a, b)
    local date_a = a[1].date
    local date_b = b[1].date
    
    -- Headings without dates go to the end
    if not date_a and not date_b then return false end
    if not date_a then return false end
    if not date_b then return true end
    
    return date_a < date_b
  end)
  
  -- Reconstruct the sorted lines
  local new_lines = {}
  for i = 1, start_line - 1 do
    table.insert(new_lines, lines[i])
  end
  
  for _, group in ipairs(groups) do
    for _, heading in ipairs(group) do
      for _, line in ipairs(heading.lines) do
        table.insert(new_lines, line)
      end
    end
  end
  
  for i = end_line + 1, #lines do
    table.insert(new_lines, lines[i])
  end
  
  -- Replace buffer contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
  print(string.format("Sorted %d headings by date", #groups))
end

-- Set up command
vim.api.nvim_create_user_command('OrgSortByDate', M.sort_by_date, {
  range = true,
  desc = 'Sort org-mode headings by date'
})

return M
