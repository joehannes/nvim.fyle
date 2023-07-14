return {
  { "rktjmp/lush.nvim" },
  -- {
  --   "max397574/colortils.nvim",
  --   cmd = "Colortils",
  --   config = function() require("colortils").setup() end,
  -- },
  {
    "levouh/tint.nvim",
    config = require("plugins.config.tint").setup,
  },
  {
    "uga-rosa/ccc.nvim",
    config = require("plugins.config.ccc").setup,
  },
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = function()
  --     require('colorful-winsep').setup({
  --       highlight = {
  --         bg = my.color.my.magenta,
  --         fg = my.color.my.aqua,
  --       },
  --       no_exec_files = { "Lazy", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "Trouble", "trouble", "TROUBLE",
  --         "terminal",
  --         "Terminal" },
  --     })
  --   end
  -- },
  -- {
  --   "rrethy/vim-hexokinase",
  --   build = "make hexokinase",
  --   config = function()
  --     vim.api.nvim_set_var("Hexokinase_highlighters", { "sign_column", "foregroundfull" })
  --   end,
  -- }
}
