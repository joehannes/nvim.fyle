local M = {}

function M.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = vim.fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fname_fmt1, fname_fmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local valid_fmt = "%s │%5d:%-3d│%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e == nil then
      break
    end
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = vim.fn.bufname(e.bufnr)
        if fname == "" then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      str = valid_fmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

function M.tint()
  local function vimodeColor()
    return my.color.my.vimode[vim.fn.mode()]
  end

  local function secondaryVimodeColor()
    return my.color.fn.background_blend(vimodeColor(), 70)
  end

  local function tertiaryVimodeColor()
    return my.color.fn.background_blend(vimodeColor(), 21)
  end

  local ok, tint = pcall(require, "tint")
  local ok_bufferline, bufferline = pcall(require, "bufferline")
  local bufferline = require("plugins.config.bufferline")
  local lines = require("heirline")
  local heirline = require("plugins.config.heirline")

  if (ok) then
    tint.refresh()
    heirline.update()
    heirline.setup(false)
    vim.api.nvim_set_hl(0, "Normal",
      { bg = my.color.util[vim.opt.background:get() .. "en"](my.color.my.vimode[vim.fn.mode()], 88) })
    tint.refresh()
  end

  if (ok_bufferline) then
    vim.schedule(function()
      bufferline.setup()
      vim.cmd.redrawtabline()
    end)
  end
end

function M.updateHighlights()
  local mode_color = my.color.my.vimode[vim.fn.mode()]

  local function secondaryVimodeColor()
    return my.color.fn.background_blend(mode_color, 70)
  end

  local function tertiaryVimodeColor()
    return my.color.fn.background_blend(mode_color, 21)
  end

  for defColor, gitSignsHl in pairs({ [my.color.my.green] = "GitSignsAdd", [my.color.my.orange] = "GitSignsChange",
    [my.color.my.red] = "GitSignsDelete" }) do
    my.color.fn.highlight_blend_bg(gitSignsHl, 90, defColor)
    my.color.fn.highlight_blend_bg(gitSignsHl .. "Nr", 73, defColor)
    my.color.fn.highlight_blend_bg(gitSignsHl .. "Ln", 21, defColor)
  end

  my.color.fn.highlight_blend_bg("CursorLine", 50, mode_color)
  my.color.fn.highlight_blend_bg("CursorColumn", 50, mode_color)
  my.color.fn.highlight_blend_bg("Visual", 37, my.color.my.yellow)
  my.color.fn.highlight_blend_bg("TSCurrentScope", 3, mode_color)
  my.color.fn.highlight_blend_bg("TreesitterContext", 21, mode_color)
  vim.api.nvim_set_hl(0, "TreesitterContextBottom",
    { underline = true, underdouble = true, fg = my.color.my.magenta, sp = my.color.my.magenta })
  vim.api.nvim_set_hl(0, "ScrollbarHandle", { bg = mode_color })
end

function M.tablinePickBuffer()
  local tabline = require("heirline").tabline
  local buflist = tabline._buflist[1]
  buflist._picker_labels = {}
  buflist._show_picker = true
  vim.cmd.redrawtabline()
  local char = vim.fn.getcharstr()
  local bufnr = buflist._picker_labels[char]
  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  end
  buflist._show_picker = false
  vim.cmd.redrawtabline()
end

_G.SIDEBAR = function()
end

function M.toggleSidebar(fn)
  if (SIDEBAR ~= nil) then SIDEBAR() end
  if (type(fn) == "function") then
    SIDEBAR = fn
    SIDEBAR()
  end
end

_G.TERMINAL_CURRENT = nil
_G.TERMINAL_LIST = {}

function M.cycleTerminal(direction)
  if (#TERMINAL_LIST < 2) then return end
  local terminal_next = nil

  if (direction) then
    for _, val in pairs(TERMINAL_LIST) do
      if (val > TERMINAL_CURRENT) then
        terminal_next = val
        break
      end
    end
    if (not terminal_next) then terminal_next = TERMINAL_LIST[0] end
  elseif (not direction) then
    for _, val in pairs(TERMINAL_LIST) do
      if (val >= TERMINAL_CURRENT) then
        break
      else
        terminal_next = val
      end
    end
    if (not terminal_next) then terminal_next = TERMINAL_LIST[#TERMINAL_LIST] end
  end

  vim.cmd(terminal_next .. "ToggleTerm")
end

function M.addTerminal(nr)
  local idx = -1
  local sel_val = nil

  for key, val in pairs(TERMINAL_LIST) do
    if (nr.id <= val) then
      idx = key
      sel_val = val
      break
    end
  end

  if (sel_val == nr.id) then return 0 end
  if (idx == -1) then
    idx = #TERMINAL_LIST
  end

  table.insert(TERMINAL_LIST, idx, nr.id)
  TERMINAL_CURRENT = nr.id
  return idx
end

-- function removeTerminal
-- a function that takes an integer variable nr
-- and removes that int from the global list/table TERMINAL_LIST
function M.removeTerminal(nr)
  local idx = 0

  for key, val in pairs(TERMINAL_LIST) do
    if (nr.id == val) then
      idx = key
      break
    end

    table.remove(TERMINAL_LIST, idx)
  end
  if (TERMINAL_CURRENT == nr.id) then
    TERMINAL_CURRENT = nil
  end
end

function M.openTerminal(nr)
  nr = nr or vim.v.count1 or 1
  vim.cmd(nr .. "ToggleTerm direction='float'")
end

function M.lineDiagnostics()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(0, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

return M
