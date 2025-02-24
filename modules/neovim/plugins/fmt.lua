local fmt = require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },
		nix = { "alejandra" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		cmake = { "cmake_format" },
	},
	format_after_save = {
		timeout_ms = 500,
		async = true,
		lsp_format = "fallback",
	},
})
