-- Define the function
local function scrollTo()
  -- Prompt the user for input
  vim.fn.inputsave()
  local name = vim.fn.input("section")
  vim.fn.inputrestore()
  -- Insert the input into the current buffer at the cursor position
  -- vim.api.nvim_put({ name }, "l", true, true)
  require'scnvim'.send( string.format("Song.scroll(%s)", name) )
  require'scnvim'.send( string.format("Song.currentSong[%s]", name) )
  vim.fn.inputsave()
  local part = vim.fn.input("part")
  vim.fn.inputrestore()
  require'scnvim'.send( string.format("Nvim.scroll(Song.currentSong[%s][%s])",name, part) )


  -- vim.fn.search("")
end

-- Map the function to a keybinding (e.g., <Leader>in)
vim.keymap.set('n', '<Leader>in', scrollTo, { noremap = true, silent = true })
