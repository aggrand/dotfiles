return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live Search (Grep)" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Git Files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Help Tags" },
    },
    opts = function(_, opts)
    local actions = require("telescope.actions")
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = {
        n = {
          ["jk"] = actions.close,
        },
      },
    })
  end,
}
