-- vim.api.nvim_set_hl(0, '@org.headline.level1.org', { bg = '#0d0708', fg = '#e2e8f0', bold = true })
-- vim.api.nvim_set_hl(0, '@org.headline.level2.org', { bg = '#0a0305', fg = '#bee3f8', bold = true })
-- vim.api.nvim_set_hl(0, '@org.headline.level3.org', { bg = '#050c0a', fg = '#d6bcfa', bold = true })

require('orgmode').setup({
	-- colors
	-- Example highlight customization for org headings
	--from Gemini
  org_src_preserve_indentation = true,
  org_edit_src_content_indentation = 0, -- or your desired indent
  org_log_done = false,

	org_agenda_files = {  '~/tank/org_roam_files/*', '~/tank/super/Mandarin.org' },
	org_refile_targets = {  '~/tank/org_roam_files/*', '~/tank/super/Mandarin.org' },
	org_default_notes_file = '~/tank/org_roam_files/refile.org',

	-- org_hide_leading_stars = true,
	org_hide_emphasis_markers = true,
	org_adapt_indentation = true,
  -- org_special_block_alist = {
  --   SuperCollider = {
  --     indentation = function(block_info)
  --       -- Custom indentation logic for SuperCollider code blocks
  --       return 2  -- 2-space indentation
  --     end
  --   }
  -- },
	org_blank_before_new_entry = { heading = false, plain_list_item = false },
	mappings = {
		org = {
			-- org_open_at_point = ',o',
			org_return = { lhs = false }, -- Disable <CR> mapping
			org_next_visible_heading = { lhs = ']h' },
			org_previous_visible_heading = { lhs = '[h' },
		},
	},
	org_capture_templates = { 
		j = {
			description = 'to today`s journal',
			-- template = '** $?%U\n\n%?',
			template = '**** %?',
			target = '~/home/org_roam_files/org.org', -- adjust path as needed
			datetree = {
				tree_type = 'custom',
				reversed = true,
				tree = {
					{
						format = '%Y',
						pattern = '^(%d%d%d%d)$',
						order = { 1 }
					},
					{
						format = '%b %d, %Y',  -- This creates "Mar 12, 2025" format
						pattern = '^(%a%a%a) (%d+), (%d%d%d%d)$',
						order = { 3, 1, 2 }  -- Year first, then month, then day for comparison
					}
				}
			}
		},

		J = {
			description = "To todays journal with line number and filename",
			template = '**** %?\non ln: %a \n %u',
			target = '~/home/org_roam_files/org.org', -- adjust path as needed
			datetree = {
				tree_type = 'custom',
				reversed = true,
				tree = {
					{
						format = '%Y',
						pattern = '^(%d%d%d%d)$',
						order = { 1 }
					},
					{
						format = '%b %d, %Y',  -- This creates "Mar 12, 2025" format
						pattern = '^(%a%a%a) (%d+), (%d%d%d%d)$',
						order = { 3, 1, 2 }  -- Year first, then month, then day for comparison
					}
				}
			}
		},  },
	})
-- Add this to your Neovim config (e.g., init.lua)
vim.api.nvim_set_keymap('x', 'iS', ':<C-u>normal! [zjV]zk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', 'iS', ':normal viS<CR>', { noremap = true, silent = true })
--
-- Define a highlight group for orgmode inline code
vim.api.nvim_set_hl(0, 'OrgInlineCode', { bg = '#3a3a3a', fg = '#f8f8f2', italic = true })
-- Save this as ~/.config/nvim/lua/journal_jump.lua
-- Then you can call it with :lua require('journal_jump').jump_to_today()

-- script from Claude
-- Add this to your existing orgmode.lua config file

-- Journal jump functions
local function jump_to_today_journal()
  local org_file = vim.fn.expand("~/home/org_roam_files/org.org")
  
  -- Get current date components
  local year = os.date("%Y")
  local month_day = os.date("%b %d, %Y")
  
  -- Open the org file if not already open
  if vim.fn.expand('%:p') ~= org_file then
    vim.cmd('edit ' .. org_file)
  end
  
  -- Search for today's entry
  local year_pattern = "^* " .. year .. "$"
  local date_pattern = "^** " .. month_day .. "$"
  
  -- Search for the date entry first
  vim.cmd('normal! gg')
  local date_found = vim.fn.search(date_pattern, 'W')
  
  if date_found > 0 then
    vim.cmd('normal! zz')
    print("Found journal entry for " .. month_day)
    return true
  end
  
  -- If date not found, look for year section
  vim.cmd('normal! gg')
  local year_found = vim.fn.search(year_pattern, 'W')
  
  if year_found > 0 then
    vim.cmd('normal! zz')
    print("Found year section " .. year .. ", you may need to create today's entry")
    return false
  end
  
  print("No existing entries found for " .. year)
  return false
end

local function create_journal_entry()
  local orgmode = require('orgmode')
  orgmode.action('capture.prompt', { keys = 'j' })
end

local function jump_or_create_journal()
  local found = jump_to_today_journal()
  if not found then
    -- Entry doesn't exist, ask if user wants to create it
    local choice = vim.fn.confirm("Today's journal entry not found. Create it?", "&Yes\n&No", 1)
    if choice == 1 then
      create_journal_entry()
    end
  end
end

-- Set up keybindings
vim.keymap.set('n', '<leader>oj', jump_or_create_journal, { desc = 'Jump to or create today\'s journal' })
vim.keymap.set('n', '<leader>jt', jump_to_today_journal, { desc = 'Jump to today\'s journal' })
vim.keymap.set('n', '<leader>jc', create_journal_entry, { desc = 'Create new journal entry' })

-- Optional: Create user commands
vim.api.nvim_create_user_command('JournalToday', jump_to_today_journal, { desc = 'Jump to today\'s journal entry' })
vim.api.nvim_create_user_command('JournalCreate', create_journal_entry, { desc = 'Create new journal entry' })
vim.api.nvim_create_user_command('Journal', jump_or_create_journal, { desc = 'Jump to or create today\'s journal' })-- Apply the highlight to inline code patterns
-- vim.cmd([[
--   augroup OrgInlineCodeHighlight
--     autocmd!
--     autocmd FileType org syntax match OrgInlineCode /`[^`]\+`/
--     " autocmd FileType org syntax match OrgInlineCode /=[^=]\+=/
--     autocmd FileType org hi link OrgInlineCode OrgInlineCode
--   augroup END
-- ]])

local function copy_org_link_to_clipboard()
  local line = vim.api.nvim_get_current_line()
  local heading = line:match("^%*+ (.+)$")
  if heading then
    local filepath = vim.fn.expand("%:p")
    local link = string.format("[[file:%s::*%s][%s]]", filepath, heading, heading)
    vim.fn.setreg("\"", link)
    print("Copied: " .. link)
  end
end

vim.keymap.set('n', '<leader>oy', copy_org_link_to_clipboard, { desc = "Copy org link to clipboard" })

-- Subtree editing functionality
local function edit_subtree_in_buffer()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  
  -- Find the current heading
  local heading_line = nil
  local heading_level = nil
  
  -- Search backwards from current line to find the heading
  for i = current_line, 1, -1 do
    local line = lines[i]
    local level = line:match("^(%*+)%s")
    if level then
      heading_line = i
      heading_level = #level
      break
    end
  end
  
  if not heading_line then
    print("No heading found")
    return
  end
  
  -- Find the end of this subtree
  local end_line = #lines
  for i = heading_line + 1, #lines do
    local line = lines[i]
    local level = line:match("^(%*+)%s")
    if level and #level <= heading_level then
      end_line = i - 1
      break
    end
  end
  
  -- Extract subtree content
  local subtree_lines = {}
  for i = heading_line, end_line do
    table.insert(subtree_lines, lines[i])
  end
  
  -- Store original buffer info
  local original_buf = vim.api.nvim_get_current_buf()
  local original_file = vim.api.nvim_buf_get_name(original_buf)
  
  -- Create new buffer for editing
  local edit_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(edit_buf, 0, -1, false, subtree_lines)
  vim.api.nvim_buf_set_option(edit_buf, 'filetype', 'org')
  vim.api.nvim_buf_set_option(edit_buf, 'buftype', 'acwrite')
  
  -- Set buffer name with timestamp to ensure uniqueness
  local heading_text = lines[heading_line]:match("^%*+%s*(.+)") or "subtree"
  local clean_heading = heading_text:gsub("[^%w%s%-_]", ""):gsub("%s+", "_")
  local timestamp = os.time()
  vim.api.nvim_buf_set_name(edit_buf, string.format("[SUBTREE] %s_%d", clean_heading, timestamp))
  
  -- Open in new window
  vim.cmd('split')
  vim.api.nvim_win_set_buf(0, edit_buf)
  
  -- Store metadata for saving back
  vim.api.nvim_buf_set_var(edit_buf, 'org_subtree_original_buf', original_buf)
  vim.api.nvim_buf_set_var(edit_buf, 'org_subtree_start_line', heading_line)
  vim.api.nvim_buf_set_var(edit_buf, 'org_subtree_end_line', end_line)
  
  -- Set up autocmd to save back to original buffer
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = edit_buf,
    callback = function()
      local ok, orig_buf = pcall(vim.api.nvim_buf_get_var, edit_buf, 'org_subtree_original_buf')
      local ok2, start_line = pcall(vim.api.nvim_buf_get_var, edit_buf, 'org_subtree_start_line')
      local ok3, end_line = pcall(vim.api.nvim_buf_get_var, edit_buf, 'org_subtree_end_line')
      
      if ok and ok2 and ok3 and vim.api.nvim_buf_is_valid(orig_buf) then
        local new_content = vim.api.nvim_buf_get_lines(edit_buf, 0, -1, false)
        
        -- Replace content in original buffer
        vim.api.nvim_buf_set_lines(orig_buf, start_line - 1, end_line, false, new_content)
        
        -- Mark original buffer as modified
        vim.api.nvim_buf_set_option(orig_buf, 'modified', true)
        
        print("Subtree updated in original buffer")
        vim.api.nvim_buf_set_option(edit_buf, 'modified', false)
      else
        print("Error: Could not save back to original buffer")
      end
    end
  })
  
  -- Add keybinding to close and save
  vim.keymap.set('n', '<leader>q', function()
    vim.cmd('write')
    vim.cmd('quit')
  end, { buffer = edit_buf, desc = "Save subtree and close" })
  
  -- Map ZZ to save and quit (like native code block editing)
  vim.keymap.set('n', 'ZZ', function()
    vim.cmd('write')
    vim.cmd('quit')
  end, { buffer = edit_buf, desc = "Save subtree and close (ZZ)" })
  
  print("Editing subtree in separate buffer. Use <leader>q to save and close.")
end

vim.keymap.set('n', '<leader>o"', edit_subtree_in_buffer, { desc = "Edit subtree in separate buffer" })
-- Simpler approach: just override C-i after orgmode loads
---- Restore C-i behavior while keeping Tab cycling in org files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    callback = function()
        vim.keymap.set('n', '<C-i>', function()
            pcall(vim.cmd, 'normal! 1\x0f')  -- Direct jumplist forward
        end, { buffer = true, desc = "Jump forward" })
    end,
})

