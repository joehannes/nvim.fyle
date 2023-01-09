local M = {
  {
    "[",
    {
      { "t", "<C-\\><C-n>:FloatermPrev<CR>" },
    },
  },
  {
    "]",
    {
      { "t", "<C-\\><C-n>:FloatermNext<CR>" },
    },
  },
  {
    "<leader>",
    {
      {
        "t",
        {
          { "t", "<C-\\><C-n>:lua require('terminal.mappings').toggle()<CR>", "toggle term" },
          { "1t", "<C-\\><C-n>:1TermOpen!<CR>", "toggle term" },
          { "2t", "<C-\\><C-n>:2TermOpen!<CR>", "toggle term" },
          { "3t", "<C-\\><C-n>:3TermOpen!<CR>", "toggle term" },
          { "4t", "<C-\\><C-n>:4TermOpen!<CR>", "toggle term" },
          { "5t", "<C-\\><C-n>:5TermOpen!<CR>", "toggle term" },
        },
      },
    },
  },
}

return M
