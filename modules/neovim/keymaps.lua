-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- escape, exiting
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diag
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open [q]uickfix list" })
