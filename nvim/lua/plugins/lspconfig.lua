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
    keys = {
        { "<leader>lc",
            function() return vim.lsp.get_clients()[1].server_capabilities end,
            desc = "View server capabilities" },
    },
    config = function()
        require("lspconfig").lua_ls.setup {}
        require("lspconfig").terraform_lsp.setup {
            cmd = { "terraform-ls", "serve" }
        }
    end
}
