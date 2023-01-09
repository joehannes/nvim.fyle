return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "octaltree/cmp-look",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "David-Kunz/cmp-npm",
      "windwp/nvim-autopairs",
    },
    config = function()
      require("plugins.config.completion").setup()
      require("cmp-npm").setup({})
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lua" },
  { "octaltree/cmp-look" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-calc" },
  { "f3fora/cmp-spell" },
  { "hrsh7th/cmp-emoji" },
  { "ray-x/cmp-treesitter" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp-document-symbol" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "David-Kunz/cmp-npm" },
  { "windwp/nvim-autopairs" },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      local tabnine = require('cmp_tabnine.config')

      tabnine:setup({
        max_lines = 50,
        max_num_results = 3,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false
      })
    end
  }
}
