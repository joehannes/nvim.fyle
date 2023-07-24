return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("plugins.config.gitsigns").setup() end,
  },
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    config = function() require("plugins.config.diffview").setup() end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("neogit").setup({ integrations = { diffview = true } })
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require('git-conflict').setup({
        default_mappings = true,    -- disable buffer local mapping created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = {
          -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
        end
      })
    end
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({
        opts = {
          remote = nil, -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").copy_to_clipboard,
          -- print the url after performing the action
          print_url = true,
        },
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
          ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
          ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
          ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
          ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
          ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
          ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
          ["repo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
          ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
          ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
        },
      })
    end,
  }
}
