return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = { theme = 'catppuccin' },
            sections = {
                lualine_c = {
                  {
                    'filename',
                    path = 3,   -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = absolute with ~
                  },
                },
              },
        }
    end
}
