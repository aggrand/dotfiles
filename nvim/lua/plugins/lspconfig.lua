return { "neovim/nvim-lspconfig",
    dependencies = {
	{
	    "folke/lazydev.nvim",
	    ft = "lua", -- only load on lua files
	    opts = {
	      library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	      },
	    },
	  },
    },
    config = function()
        require("lspconfig").lua_ls.setup {}
        require("lspconfig").terraform_lsp.setup {
            cmd = { "terraform-ls", "serve" }
        }

        vim.lsp.get_active_clients()
        vim.keymap.set("n", "<leader>lc", function()
            vim.print(vim.lsp.get_clients()[1].capabilities)
        end, { desc = "Print LSP client capabilities" })

        -- Open diagnostic on hover
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
          end,
        })

    end
}
