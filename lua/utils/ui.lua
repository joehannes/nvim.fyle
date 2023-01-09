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
  local ok, tint = pcall(require, "tint")
  -- local bufferline = require("plugins.config.bufferline")
  local lines = require("heirline")
  local heirline = require("plugins.config.heirline")

  if (ok) then
    tint.refresh()
    lines.reset_highlights()
    heirline.load_colors()
    -- bufferline.setup()
    heirline.setup(false)
    tint.refresh()
  end
end

function M.updateHighlights()
  local mode_color = my.color.my.vimode[vim.fn.mode()]

  for defColor, gitSignsHl in pairs({ [my.color.my.green] = "GitSignsAdd", [my.color.my.orange] = "GitSignsChange",
    [my.color.my.red] = "GitSignsDelete" }) do
    my.color.fn.highlight_blend_bg(gitSignsHl, 90, defColor)
    my.color.fn.highlight_blend_bg(gitSignsHl .. "Nr", 73, defColor)
    my.color.fn.highlight_blend_bg(gitSignsHl .. "Ln", 50, defColor)
    my.color.fn.highlight_blend_bg("CursorLine", 50, mode_color)
    my.color.fn.highlight_blend_bg("CursorColumn", 50, mode_color)
    my.color.fn.highlight_blend_bg("Visual", 21, mode_color)
    my.color.fn.highlight_blend_bg("TSCurrentScope", 12, mode_color)
    my.color.fn.highlight_blend_bg("TreesitterContext", 50, mode_color)
    vim.api.nvim_set_hl(0, "TreesitterContextBottom",
      { underline = true, underdouble = true, fg = my.color.my.magenta, sp = my.color.my.magenta })
    vim.api.nvim_set_hl(0, "ScrollbarHandle", { bg = mode_color })
  end
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

return M
