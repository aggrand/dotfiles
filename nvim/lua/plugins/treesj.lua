return {
  'Wansmer/treesj',
  keys = { '<space>j' },
  dependencies = {'nvim-treesitter/nvim-treesitter'}, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({--[[ your config ]]})
    vim.keymap.set('n', '<leader>j', require('treesj').toggle)
    vim.keymap.set('n', '<leader>J', function()
        require('treesj').toggle({split = {recursive = true}})
    end)
  end,
}
