return {
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },
  {
    "rebelot/heirline.nvim",
    config = function()
      require("plugins.config.heirline").setup(true)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function() require("plugins.config.bufferline").setup() end,
  },
}
