return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				inlay_hints = { enabled = true },
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pylsp")
		vim.lsp.enable("terraform_lsp")
		vim.lsp.config("terraform_lsp", {
			cmd = { "terraform-ls", "serve" },
		})
		vim.lsp.enable("gopls")
		vim.lsp.config("gopls", {
			cmd = { "gopls", "serve" },
		})

		vim.keymap.set("n", "<leader>lc", function()
			vim.print(vim.lsp.get_clients()[1].capabilities)
		end, { desc = "Print LSP client capabilities" })

		-- An example nvim-lspconfig capabilities setting
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		vim.lsp.enable("markdown_oxide")
		vim.lsp.config("markdown_oxide", {
			-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
			-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
			-- on_attach = on_attach, -- configure your on attach config
		})

		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "markdown",
		-- 	callback = function(args)
		-- 		vim.lsp.start({
		-- 			name = "iwes",
		-- 			cmd = { "iwes" },
		-- 			root_dir = vim.fs.root(args.buf, { ".iwe" }),
		-- 			flags = {
		-- 				debounce_text_changes = 500,
		-- 			},
		-- 		})
		-- 	end,
		-- })

		-- Open diagnostic on hover
		--[[ vim.api.nvim_create_autocmd("CursorHold", {
          callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
          end,
        })]]

		--[[ vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })]]
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List references" })
	end,
}
