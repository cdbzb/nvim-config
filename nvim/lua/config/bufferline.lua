local status, bufferline = pcall(require, "bufferline")
if not status then
  print("ERROR bufferline")
  return
end
bufferline.setup{
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
	    numbers = "ordinal",
            custom_filter = function(buf_number, buf_numbers)
                if vim.fn.bufname(buf_number) ~= "" then
                    return true
                end
            end,
        }
}
