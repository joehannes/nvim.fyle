local M = {
  { "<C-h>", '<Cmd>call WinMove("h")<CR>', "left win",  '<Cmd>call WinMove("l")<CR>' },
  { "<C-l>", '<Cmd>call WinMove("l")<CR>', "right win", '<Cmd>call WinMove("h")<CR>' },
  { "<C-k>", '<Cmd>call WinMove("k")<CR>', "up win",    '<Cmd>call WinMove("j")<CR>' },
  { "<C-j>", '<Cmd>call WinMove("j")<CR>', "down win",  '<Cmd>call WinMove("k")<CR>' },
  {
    "[",
    {
      { "t", "<C-\\><C-n><Cmd>lua my.ui.cycleTerminal(false)<CR>", "prev term",
        "<C-\\><C-n><Cmd>lua my.ui.cycleTerminal(true)<CR>", },
    },
  },
  {
    "]",
    {
      { "t", "<C-\\><C-n><Cmd>lua my.ui.cycleTerminal(true)<CR>", "next term",
        "<C-\\><C-n><Cmd>lua my.ui.cycleTerminal(false)<CR>", },
    },
  },
  {
    "<leader>",
    {
      {
        "t",
        {
          { "t", [[<C-\\><C-n><Cmd>ToggleTermToggleAll<CR>]], "toggle term" },
        },
      },
    },
  },
}

return M
