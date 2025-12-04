return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt" },
			markdown = { lsp_format = "prefer" }, -- TODO: Consider "last" if others?
			terraform = { "terraform_fmt" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
