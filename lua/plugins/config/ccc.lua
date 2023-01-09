local M = {}

function M.setup()
  local ccc = require("ccc")

  ccc.setup({
    save_on_quit = true,
    inputs = {
      ccc.input.rgb,
      ccc.input.hsl,
    }
  })
end

return M
