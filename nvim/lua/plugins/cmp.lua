return {
  "hrsh7th/nvim-cmp",
  event = {"InsertEnter", "CmdlineEnter"},
  dependencies = {
    "ray-x/cmp-treesitter",     -- Completion source from treesitter
    "hrsh7th/cmp-nvim-lsp",     -- Completion source from LSP
    "hrsh7th/cmp-buffer",       -- Words in open buffers
    "hrsh7th/cmp-path",         -- File paths
    "hrsh7th/cmp-cmdline",      -- Cmdline completion
    "L3MON4D3/LuaSnip",         -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet completions
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Enter>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort()
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "treesitter" },
        { name = "buffer" },
        { name = "path" },
      }),
      experimental = {
        ghost_text = true,
      },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
    --  cmp.setup.cmdline('/', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'buffer' }
    --   }
    -- })
  end,
}
