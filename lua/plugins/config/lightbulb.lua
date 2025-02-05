local M = {}

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

function M.setup()
  require("nvim-lightbulb").update_lightbulb({
    sign = {
      enabled = true,
      text = "☼", -- "💡",
      priority = 20,
    },
    float = {
      enabled = false,
      -- Text to show in the popup float
      text = "☼", -- "💡",
      -- text = "💡",
      -- Available keys for window options:
      -- - height     of floating window
      -- - width      of floating window
      -- - wrap_at    character to wrap at for computing height
      -- - max_width  maximal width of floating window
      -- - max_height maximal height of floating window
      -- - pad_left   number of columns to pad contents at left
      -- - pad_right  number of columns to pad contents at right
      -- - pad_top    number of lines to pad contents at top
      -- - pad_bottom number of lines to pad contents at bottom
      -- - offset_x   x-axis offset of the floating window
      -- - offset_y   y-axis offset of the floating window
      -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
      -- - winblend   transparency of the window (0-100)
      win_opts = {},
    },
    virtual_text = {
      enabled = true,
      -- Text to show at virtual text
      text = "☼", -- "💡",
    },
  })
end

return M
