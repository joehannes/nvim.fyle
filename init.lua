--@diagnostic disable:undefined-global
vim.cmd([[
  set shell=/opt/homebrew/bin/zsh
]])

require("utils")

vim.api.nvim_set_var("mapleader", " ")
vim.api.nvim_set_var("maplocalleader", ";")

require("settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  root = vim.fn.stdpath("data") .. "/lazy",
  spec = {
    import = "plugins",
  },
  defaults = { lazy = false, version = "*" },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
  diff = {
    cmd = "git",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
      },
    },
  },
  git = {
    timeout = 500,
  },
  ui = {
    custom_keys = {
    },
  },
  debug = false,
})

require("lang")
require("keymappings")
require("colorschemes")

-- vim.cmd("colo lush_jsx")
