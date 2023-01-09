local M = {}
function M.setup()
  local tint = require("tint")
  local transforms = require("tint.transforms")

  tint.setup({
    tint = -45, -- Darken colors, use a positive value to brighten
    saturation = 0.6, -- Saturation to preserve
    transforms = {
      -- transforms.saturate(0.5),
      transforms.tint_with_threshold(-100, "#000000", 100)
    }, -- Showing default behavior, but value here can be predefined set of transforms
    tint_background_colors = true, -- Tint background portions of highlight groups
    highlight_ignore_patterns = { "WinSeparator", "StatusLine", "StatusLineNC", "WinBar",
      "WinBarNC", "HeirLine" },
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

      -- Do not tint `terminal` or floating windows, tint everything else
      return buftype == "terminal" or floating
    end
  })
end

return M
