return {
  "smjonas/inc-rename.nvim",
  opts = {},
  config = function ()
    require("inc_rename").setup({})
    vim.keymap.set("n", "grn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
  end
}
