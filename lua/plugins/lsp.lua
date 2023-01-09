return {
  {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("nvim-lsp-installer").setup({
        automatic_installation = true,
      })
    end,
  },
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/typescript.nvim" },
  {
    "onsails/lspkind-nvim",
    config = function() require("plugins.config.lspkind").setup() end,
  },
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "joehannes-nvim/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup { sync = true } --sync = true
    end
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "folke/lsp-colors.nvim",
    config = function()
      require("plugins.config.lspcolors").setup()
    end,
  }
}
