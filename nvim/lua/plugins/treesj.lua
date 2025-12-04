return {
  'Wansmer/treesj',
  keys = {
    { '<space>j', desc = "Toggle join of syntactic node" },
    { '<space>J', desc = "Toggle recursive join of syntactic node" },
  },
  dependencies = {'nvim-treesitter/nvim-treesitter'}, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({
        use_default_keymaps = false,
    })
    vim.keymap.set('n', '<leader>j', require('treesj').toggle, {desc = "Toggle join of syntactic node"})
    vim.keymap.set('n', '<leader>J', function()
        require('treesj').toggle({split = {recursive = true}})
    end, {desc = "Toggle recursive join of syntactic node"})
  end,
}
