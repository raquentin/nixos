require("which-key").setup()

require("which-key").add({
    { "<leader>c", group = "[c]ode" },
    { "<leader>d", group = "[d]ocument" },
    { "<leader>r", group = "[r]ename" },
    { "<leader>s", group = "[s]earch" },
    { "<leader>w", group = "[w]orkspace" },
    { "<leader>t", group = "[t]oggle" },
    { "<leader>h", group = "git [h]unk", mode = { "n", "v" } },
})
