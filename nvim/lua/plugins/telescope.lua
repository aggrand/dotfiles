return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		-- Files
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },

		-- Buffers
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Vim Marks" },
		-- { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Show Jumplist" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search in current buffer" },

		-- LSP
		{ "grr", "<cmd>Telescope lsp_references<cr>", desc = "Find References" },
		{ "gri", "<cmd>Telescope lsp_implementations<cr>", desc = "Find Implementations" },
		{ "grd", "<cmd>Telescope lsp_definitions<cr>", desc = "Find Definitions" },
		{ "grt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Find Type Definitions" },
		{ "grs", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find Workspace Symbols" },
	},
	opts = function(_, opts)
		-- local actions = require("telescope.actions")
		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			initial_mode = "normal",
			--[[mappings = {
            n = {
              ["jk"] = actions.close,
            },
          },]]
		})
		opts.extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		-- To get fzf loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require("telescope").load_extension("fzf")
	end,
}
