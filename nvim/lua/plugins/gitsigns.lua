return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>bb", "<cmd>Gitsigns blame<cr>", desc = "Open git blame" },
	},
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 0,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
		})
	end,
}
