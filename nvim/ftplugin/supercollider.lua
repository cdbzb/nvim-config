-- define the function to count occurrences
function songSections()
  local count = 0
  for _ in string.gmatch(vim.api.nvim_buf_get_lines(0, 0, -1, false), 'addLine') do
    count = count + 1
  end
  return count
end

function send_midi_item_gui_under_cursor()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    
    -- Pattern to match the entire MIDIItem("...") expression
    local midi_item_expr = line:match('MIDIItem%("([^"]*)"%)') 
    
    if midi_item_expr then
        -- Send the complete MIDIItem expression with .gui
        local command = 'MIDIItem("' .. midi_item_expr .. '").gui'
        require'scnvim'.send(command)
        print("Sent: " .. command)
        return true -- Success
    else
        print("No MIDIItem found on current line")
        return false -- No MIDIItem found
    end
end

function send_register_d_gui()
    -- Get the content of register 'd'
    local content = vim.fn.getreg('d')
    
    if content and content ~= '' then
        require'scnvim'.send(content .. ".gui")
        print("Sent from register d: " .. content)
        return true
    else
        print("Register d is empty")
        return false
    end
end

