require("telescope").setup({})

-- enable extensions
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[s]earch [s]elect telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch [w]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch [g]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iag" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[s]earch recents' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "find[ ]buffers" })

vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "live grep in open files"
  })
end, { desc = "[s]earch [/] in open files" })

vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[s]earch [n]eovim files" })
