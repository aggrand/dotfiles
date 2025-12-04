return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		-- TODO: Make it a toggle? Or fix the telescope integration
		{ "<leader>lt", "<cmd>TodoTrouble<cr>", desc = "Show TODOs" },
	},
	opts = {
		-- refer to the configuration section below
	},
}
