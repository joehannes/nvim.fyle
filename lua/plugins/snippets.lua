return {
  -- { "hrsh7th/vim-vsnip" },
  -- { "xabikos/vscode-javascript" },
  -- { "stevearc/vim-vsnip-snippets" },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local/git/joehannes-nvim/snipptes" } })
    end
  },
}
