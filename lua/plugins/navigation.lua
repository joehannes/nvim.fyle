return {
  { "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = true,
        mappings = {
          annotate = "m@",
          m0 = false,
          m1 = false,
          m2 = false,
          m3 = false,
          m4 = false,
          m5 = false,
          m6 = false,
          m7 = false,
          m8 = false,
          m9 = false,
        },
        bookmark_0 = {
          sign = "",
          virt_text = " ( 0) ",
        },
        bookmark_1 = {
          sign = "",
          virt_text = " ( 1) ",
        },
        bookmark_2 = {
          sign = "",
          virt_text = " ( 2) ",
        },
        bookmark_3 = {
          sign = "",
          virt_text = " ( 3) ",
        },
        bookmark_4 = {
          sign = "",
          virt_text = " ( 4) ",
        },
        bookmark_5 = {
          sign = "",
          virt_text = " ( 5) ",
        },
        bookmark_6 = {
          sign = "",
          virt_text = " ( 6) ",
        },
        bookmark_7 = {
          sign = "",
          virt_text = " ( 7) ",
        },
        bookmark_8 = {
          sign = "",
          virt_text = " ( 8) ",
        },
        bookmark_9 = {
          sign = "",
          virt_text = " ( 9) ",
        },
      })
    end,
  },
  {
    "cbochs/portal.nvim",
    config = function() require("plugins.config.portal").setup() end,
  },
  {
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  }
}
