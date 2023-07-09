return {
  { "renerocksai/calendar-vim" },
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require "telekasten".setup({
        home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
      })
      vim.cmd([[
        hi tkLink ctermfg=Blue cterm=bold,underline guifg=Blue gui=bold,underline
        hi tkBrackets ctermfg=Magenta guifg=Magenta
      ]])
    end
  }
}
