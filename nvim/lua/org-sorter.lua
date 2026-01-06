local M = {}

-- Helper: Parse month names to numbers
local month_names = {
  Jan = "01", Feb = "02", Mar = "03", Apr = "04",
  May = "05", Jun = "06", Jul = "07", Aug = "08",
  Sep = "09", Oct = "10", Nov = "11", Dec = "12"
}

-- Extract date from text.
local function extract_date(text)
  -- 🌟 CRITICAL FIX: Ensure the input is a string before using string functions.
  if type(text) ~= 'string' then return nil end 

  -- 1. Try ISO Format (Standard Org) -> YYYY-MM-DD
  -- Supports <2025-10-30> or [2025-10-30]
  local iso_year, iso_month, iso_day = text:match("[%[<](%d%d%d%d)%-(%d%d)%-(%d%d)[%]>]")
  if iso_year then
    return string.format("%s-%s-%s", iso_year, iso_month, iso_day)
  end

  -- 2. Try Verbose Format -> Month Day, Year (anywhere in the line)
  local month_str, day, year = text:match("(%a+)%s+(%d+),%s+(%d%d%d%d)")
  
  if month_str and day and year then
    local month = month_names[month_str]
    if month then
      return string.format("%s-%s-%02d", year, month, tonumber(day))
    end
  end
  
  return nil
end

-- Parse org buffer into heading groups, collecting non-heading lines into preamble
local function parse_headings(lines)
  local headings = {}
  local preamble = {} 
  local current = nil
  
  for _, line in ipairs(lines) do
    local stars = line:match("^(%*+)%s")
    
    if stars then
      if current then
        table.insert(headings, current)
      end
      current = {
        level = #stars,
        lines = {line},
        date = extract_date(line) -- Extract date from heading itself
      }
    elseif current then
      table.insert(current.lines, line)
    else
      -- Lines before the first heading are stored in preamble
      table.insert(preamble, line)
    end
  end
  
  if current then
    table.insert(headings, current)
  end
  
  return headings, preamble
end

-- Sort headings by date (Newest First)
function M.sort_by_date(opts)
  -- Use 1-based line numbers from the command
  local start_line = opts.line1
  local end_line = opts.line2
  
  local buf = vim.api.nvim_get_current_buf()
  -- Get only the selected lines (0-indexed API)
  local lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
  
  if #lines == 0 then return end

  -- Parse
  local headings, preamble = parse_headings(lines)
  
  if #headings == 0 then
    print("No headings found in selection")
    return
  end
  
  -- Find the minimum level to determine the main groups for sorting
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
      -- Sub-headings are bundled with the previous main heading
      table.insert(current_group, heading)
    end
  end
  if #current_group > 0 then
    table.insert(groups, current_group)
  end
  
  -- Sort each group by date (Newest First)
  table.sort(groups, function(a, b)
    local date_a = a[1].date
    local date_b = b[1].date
    
    -- Headings without dates go to the bottom (false = a does not come before b)
    if not date_a and not date_b then return false end
    if not date_a then return false end 
    if not date_b then return true end
    
    -- Return true if date_a (the first item) is MORE recent (greater) than date_b
    return date_a > date_b
  end)
  
  -- Reconstruct the sorted lines
  local new_lines = {}
  
  -- Add preamble back first (preserve text before first header)
  for _, line in ipairs(preamble) do
    table.insert(new_lines, line)
  end

  for _, group in ipairs(groups) do
    for _, heading in ipairs(group) do
      for _, line in ipairs(heading.lines) do
        table.insert(new_lines, line)
      end
    end
  end
  
  -- Replace only the selected range
  vim.api.nvim_buf_set_lines(buf, start_line - 1, end_line, false, new_lines)
  print(string.format("Sorted %d items by date (Newest First)", #groups))
end

-- Set up command
vim.api.nvim_create_user_command('OrgSortByDate', M.sort_by_date, {
  range = true,
  desc = 'Sort org-mode headings by date'
})

return M
