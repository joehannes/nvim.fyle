local M = {
  neovide_transparency = 0.9,
  transparency = 1,
  neovide_cursor_trail_size = 1,
  neovide_cursor_vfx_mode = "ripple",
  asyncrun_open = 6,
  asynctasks_profile = 'npm',
  floaterm_height = 0.9,
  floaterm_width = 0.9,
  floaterm_wintype = "floating",
  floaterm_winblend = 10,
  neoranger_viewmode = "miller",
  neoranger_opts = "--cmd=\"set show_hidden true\"",
  parinfer_mode = "smart",
  parinfer_force_balance = false,
  Powerline_symbols = "fancy",
  grepper = { tools = { "rg", "grep" }, searchreg = 1 },
  python_host_prog = my.fs.path.python2:gsub("%s+", ""),
  python3_host_prog = my.fs.path.python3:gsub("%s+", ""),
}

return M
