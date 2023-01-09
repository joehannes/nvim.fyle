local M = {}

function M.setup()
  require("glow").setup({
    width = 120,
    width_ratio = 1,
    height_ratio = 1,
  })
end

return M
