vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
vim.keymap.set("n", ",g", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
 
vim.keymap.set("n", "<space>gb", "<Plug>(neorg.telescope.backlinks.file_backlinks)", { buffer = true})
vim.keymap.set("n", "dn", ":s/\\.norg//g<CR>", { buffer = true})



