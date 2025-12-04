return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-mini/mini.icons', 'nvim-treesitter' },
    config = function()
        require('render-markdown').setup({})
    end,
}
