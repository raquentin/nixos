vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

require("neo-tree").setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filesystem = {
    hijack_netrw_behavior = "open_default",
    filtered_items = {
      always_show = {
        ".env",
      },
    },
  },
  window = {
    position = "current",
  },
  vim.keymap.set(
    "n",
    "<leader>e",
    "<Cmd>Neotree toggle<CR>",
    { desc = "toggle [e]xplorer" }
  ),
})
