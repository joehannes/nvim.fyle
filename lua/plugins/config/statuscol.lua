local M = {}

function M.setup()
  local statuscol = require("statuscol")
  local builtin = require("statuscol.builtin")
  local cfg = {
    separator     = "│", -- separator between line number and buffer text ("│" or extra " " padding)
    -- Builtin line number string options for ScLn() segment
    thousands     = false, -- or line number thousands separator string ("." / ",")
    relculright   = false, -- whether to right-align the cursor line number with 'relativenumber' set
    -- Custom line number string options for ScLn() segment
    lnumfunc      = nil, -- custom function called by ScLn(), should return a string
    reeval        = false, -- whether or not the string returned by lnumfunc should be reevaluated
    -- Builtin 'statuscolumn' options
    setopt        = true, -- whether to set the 'statuscolumn', providing builtin click actions
    segments      = {
      { text = { "%C" }, click = "v:lua.ScFa" },
      { text = { "%s" }, click = "v:lua.ScSa" },
      {
        text = { builtin.lnumfunc, " " },
        condition = { true, builtin.not_empty },
        click = "v:lua.ScLa",
      }
    },
    clickhandlers = { -- builtin click handlers
      Lnum                    = builtin.lnum_click,
      FoldClose               = builtin.foldclose_click,
      FoldOpen                = builtin.foldopen_click,
      FoldOther               = builtin.foldother_click,
      DapBreakpointRejected   = builtin.toggle_breakpoint,
      DapBreakpoint           = builtin.toggle_breakpoint,
      DapBreakpointCondition  = builtin.toggle_breakpoint,
      DiagnosticSignError     = builtin.diagnostic_click,
      DiagnosticSignHint      = builtin.diagnostic_click,
      DiagnosticSignInfo      = builtin.diagnostic_click,
      DiagnosticSignWarn      = builtin.diagnostic_click,
      GitSignsTopdelete       = builtin.gitsigns_click,
      GitSignsUntracked       = builtin.gitsigns_click,
      GitSignsAdd             = builtin.gitsigns_click,
      GitSignsChange          = builtin.gitsigns_click,
      GitSignsChangedelete    = builtin.gitsigns_click,
      GitSignsDelete          = builtin.gitsigns_click,
      gitsigns_extmark_signs_ = builtin.gitsigns_click,
    }
  }

  statuscol.setup(cfg)
end

return M
