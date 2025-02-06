local fmt = require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt" },
    nix = { "alejandra" },
  },
  format_on_save = {
    timeout_ms = 500,
    async = true,
    lsp_format = "fallback",
  },
})
