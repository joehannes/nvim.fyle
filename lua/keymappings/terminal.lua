local M = {
  { "<C-h>", '<Cmd>call WinMove("h")<CR>', "left win", '<Cmd>call WinMove("l")<CR>' },
  { "<C-l>", '<Cmd>call WinMove("l")<CR>', "right win", '<Cmd>call WinMove("h")<CR>' },
  { "<C-k>", '<Cmd>call WinMove("k")<CR>', "up win", '<Cmd>call WinMove("j")<CR>' },
  { "<C-j>", '<Cmd>call WinMove("j")<CR>', "down win", '<Cmd>call WinMove("k")<CR>' },
  {
    "[",
    {
      { "t", "<C-\\><C-n>:lua require('terminal.mappings').cycle_prev()<CR>" },
    },
  },
  {
    "]",
    {
      { "t", "<C-\\><C-n>:lua require('terminal.mappings').cycle_next()<CR>" },
    },
  },
  {
    "<leader>",
    {
      {
        "t",
        {
          { "t", [[<C-\\><C-n><Cmd>exe v:count1 . "ToggleTerm"<CR>]], "toggle term" },
        },
      },
    },
  },
}

return M
