local M = {
  { "<f20>", "<C-o>" },
  { "<C-Del>", '<cmd>lua require("notify").dismiss()<cr>' },
  { "<C-l>", "<cmd>lua require('neogen').jump_next()<CR>" },
  { "<C-h>", "<cmd>lua require('neogen').jump_prev()<CR>" },
  { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
}

return M
