---@diagnostic disable: undefined-global

local vim_vars = require('settings.variables')
local vim_options = require('settings.options')
local vim_aucmds = require('settings.aucmds')
local vim_settings = require('settings.settings')

for key, value in pairs(vim_vars) do
  vim.api.nvim_set_var(key, value)
end

for key, value in pairs(vim_options) do
  vim.api.nvim_set_option(key, value)
end

vim.opt.listchars:append("eol:↴")
-- vim.opt.fillchars:append("fold:•")
-- vim.opt.fillchars:append("foldopen:")
-- vim.opt.fillchars:append("foldsep:│")
-- vim.opt.fillchars:append("foldclose:")

for group, group_v in pairs(vim_aucmds) do
  local group_id = vim.api.nvim_create_augroup(group, { clear = true })
  local split = function(s, pattern)
    local result = {}

    for v in s:gmatch(pattern) do
      v = v:gsub(",", "")
      if v ~= nil and #v > 0 and v:match("%a+") ~= nil then
        if #result > 0 then
          table.insert(result, v)
        else
          result = { v }
        end
      end
    end

    return result
  end
  local aucmd = function(_group, events, pattern, _callback)
    local patterns

    if pattern:find(",", 1, true) == nil then
      patterns = "" .. pattern
    else
      patterns = split(pattern, "[%w.*]*,?")
    end

    vim.api.nvim_create_autocmd(events, { pattern = patterns, callback = _callback, group = _group })
  end

  for ev, cmds in pairs(group_v) do
    if not (cmds.pattern ~= nil or cmds.callback ~= nil) then
      for _, cmd in ipairs(cmds) do
        aucmd(group_id, ev, cmd.pattern, cmd.callback)
      end
    else
      aucmd(group_id, ev, cmds.pattern, cmds.callback)
    end
  end
end

vim.cmd(vim_settings)
