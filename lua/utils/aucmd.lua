local M = {}

function M.onAfterBoot(opts)
  vim.api.nvim_set_option_value("winheight", 999, { scope = "global" })
  vim.api.nvim_set_option_value("winwidth", 999, { scope = "global" })
  vim.api.nvim_set_option_value("winminheight", 0, { scope = "global" })
  vim.api.nvim_set_option_value("winminwidth", 0, { scope = "global" })
  my.ui.updateHighlights()
  my.ui.tint()
  vim.cmd([[
      WindowsEnableAutowidth
    ]])
end

function M.onColorscheme()
  my.ui.updateHighlights()
  my.ui.tint()
  vim.api.nvim_set_var("neovide_background_color", my.color.my.vimode[vim.fn.mode()] .. my.color.fn.transparentizeColor())
end

function M.onModeChanged()
  local m = vim.fn.mode()

  if (m == "c") then
    my.ui.updateHighlights()
    my.ui.tint()
  end

  vim.schedule(function()
    if (m == "n") then
      vim.cmd("startinsert")
      my.ui.updateHighlights()
      vim.schedule(function()
        vim.cmd([[
          stopinsert
        ]])
        my.ui.updateHighlights()
        my.ui.tint()
      end)
    end

    my.ui.updateHighlights()
    my.ui.tint()
  end)
end

function M.toggle_bg_mode(force)
  local current = vim.opt.background:get()
  local other = current == "light" and "dark" or "light"

  vim.api.nvim_set_option("background", force and current or other)

  my.ui.updateHighlights()
  my.ui.tint()
end

function M.applyWinSeparatorNCHighlight()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  vim.api.nvim_set_hl_ns(ns_winsep)
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = my.color.my.aqua, bg = "bg", nocombine = false })
end

function M.activate_current_win_sep()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  vim.api.nvim_set_hl(ns_winsep, "WinSeparator", { fg = my.color.my.aqua, bg = my.color.my.magenta })
end

function M.clear_current_win_sep()
  local ns_winsep = vim.api.nvim_create_namespace("CurrentBuffer")
  vim.api.nvim_buf_clear_namespace(0, ns_winsep, 0, -1) -- not working, why?
end

return M
