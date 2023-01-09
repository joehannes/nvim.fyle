return {
  {
    "kyazdani42/nvim-web-devicons",
    config = function() require('plugins/config/devicon').setup() end,
  },
  {
    "mortepau/codicons.nvim",
    config = function() require("plugins/config/codicons").setup() end,
  },
}
