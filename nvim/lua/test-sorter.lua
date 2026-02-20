-- diagnostic.lua
local function diagnose_date(text)
  local out = {}
  table.insert(out, "=== Diagnosing: [" .. text .. "] ===")
  
  -- Show raw bytes
  table.insert(out, "Bytes:")
  for i = 1, math.min(#text, 30) do
    local b = text:byte(i)
    local char = (b >= 32 and b < 127) and string.char(b) or ("<%d>"):format(b)
    table.insert(out, ("  %2d: %3d  %s"):format(i, b, char))
  end
  
  -- Try the gsub
  local cleaned = text:gsub("^%*+%s*", "")
  table.insert(out, "\nAfter gsub('^%*+%s*', ''): [" .. cleaned .. "]")
  
  -- Try the match
  local month_str, day, year = cleaned:match("^%s*(%a+)%s+(%d+),%s*(%d%d%d%d)")
  table.insert(out, "\nMatch results:")
  table.insert(out, "  month_str: " .. (month_str or "NIL"))
  table.insert(out, "  day: " .. (day or "NIL"))
  table.insert(out, "  year: " .. (year or "NIL"))
  
  -- Try looser match directly on original
  local m2, d2, y2 = text:match("(%a%a%a)%s+(%d%d?),?%s*(%d%d%d%d)")
  table.insert(out, "\nLoose match on original:")
  table.insert(out, "  month: " .. (m2 or "NIL"))
  table.insert(out, "  day: " .. (d2 or "NIL"))
  table.insert(out, "  year: " .. (y2 or "NIL"))
  
  return table.concat(out, "\n")
end

-- Get current line
local line = vim.api.nvim_get_current_line()
local result = diagnose_date(line)

-- Write to file
local f = io.open("/tmp/date-diagnostic.txt", "w")
f:write(result)
f:close()

print("Output written to /tmp/date-diagnostic.txt")
