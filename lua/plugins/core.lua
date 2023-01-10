return {
  { "Olical/aniseed" },
  { "nvim-lua/plenary.nvim" },
  { "stevearc/dressing.nvim" },
  { "nvim-lua/popup.nvim" },
  { "MunifTanjim/nui.nvim" },
  {
    "ellisonleao/glow.nvim",
    config = function() require("plugins.config.glow").setup() end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function() require("plugins.config.notify").setup() end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("plugins.config.statuscol").setup()
    end,
  },
  {
    "rmagatti/auto-session",
    config = function() require("plugins.config.auto_session").setup() end,
  },
  { "tversteeg/registers.nvim" },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require("plugins.config.ufo").setup()
    end
  },
  {
    "gelguy/wilder.nvim",
    config = function() require("plugins.config.wilder").setup() end,
  },
  { "indianboy42/hop-extensions" },
  {
    "karb94/neoscroll.nvim",
    config = function() require("plugins.config.scroll").setup() end,
  },
  -- { "unblevable/quick-scope" },
  {
    'rebelot/terminal.nvim',
    config = function() require("terminal").setup({
        layout = { open_cmd = "float", width = 0.9, height = 0.9 },
        cmd = { vim.o.shell },
        autoclose = false,
      })
    end,
  },
  { "lokaltog/neoranger" },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      })
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function() require("plugins.config.lightbulb").setup() end,
  },
  {
    'mrshmllow/document-color.nvim',
    config = function()
      require("document-color").setup {
        -- Default options
        mode = "background", -- "background" | "foreground" | "single"
      }
    end
  },
  { "mhinz/vim-grepper" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
      })
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        input_after_comment = true,
        languages = {
          javascript = {
            template = {
              annotation_convention = "jsdoc",
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "jsdoc",
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc",
            }
          },
          typescriptreact = {
            template = {
              annotation_convention = "tsdoc",
            }
          }
        }
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- stable versions only
    -- tag = "*"
  }
}
