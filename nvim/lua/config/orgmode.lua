require('orgmode').setup({
	--from Gemini
  org_src_preserve_indentation = true,
  org_edit_src_content_indentation = 0, -- or your desired indent

	org_agenda_files = {  '~/tank/org_roam_files/*', '~/tank/org_roam_files/daily/*' },
	org_refile_targets = {  '~/tank/org_roam_files/*', '~/tank/org_roam_files/daily/*' },
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
			org_open_at_point = ',g',
			org_return = nil, -- Disable <CR> mapping
      org_next_visible_heading = ']h',
      org_previous_visible_heading = '[h',
		},
	},
	org_capture_templates = { 
		d = {
			description = "Todo (Daily Note)",
			template = "* TODO %?\n  %u", -- %u = inactive timestamp
			target = "~/tank/org_roam_files/daily/%<%Y-%m-%d>.org", -- Auto-filename by date
		},
		j = {
			description = 'Journal (LogSeq style)',
			-- template = '** $?%U\n\n%?',
			template = '**** %?',
			target = '~/tank/org_roam_files/org.org', -- adjust path as needed
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

		D = {
			description = "Todo (Daily Note) with linenum",
			template = '**** TODO %?\non ln: %a \n %u',
			-- template = "* TODO %?\n  %u", -- %u = inactive timestamp
			target = "~/tank/org_roam_files/daily/%<%Y-%m-%d>.org", -- Auto-filename by date
		},
		m = {
			description = 'Mandarin',
			template = '**** on ln: %a %?\n %u',
			target = '~/tank/super/scd/Mandarin/INDEX.org'

		},
		n = {
			description = "Note with line number and filename",
			template = '**** %?\non ln: %a \n %u',
			target = "~/tank/org_roam_files/org.org",
			headline = 'Refile', -- Prompt for a heading
			datetree = true
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
  local org_file = vim.fn.expand("~/tank/org_roam_files/org.org")
  
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

