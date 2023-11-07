local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
-- local constructors = require("heirline.constructors")

local function vimode_color()
  return my.color.my.vimode[vim.fn.mode() or "n"] or my.color.my.vimode["n"]
end

local function setup_colors()
  local dark_mode = vim.opt.background:get() == "dark"

  return {
    vimode = vimode_color(),
    light = my.color.my.light,
    dark = my.color.my.dark,
    current_bg = dark_mode and my.color.my.dark or my.color.my.light,
    current_fg = dark_mode and my.color.my.light or my.color.my.dark,
    red = my.color.my.red,
    magenta = my.color.my.magenta,
    green = my.color.my.green,
    blue = my.color.my.blue,
    gray = utils.get_highlight("NonText").fg,
    yellow = my.color.my.yellow,
    orange = my.color.my.orange,
    purple = my.color.my.purple,
    aqua = my.color.my.aqua,
    diag_warn = my.color.my.orange,
    diag_error = my.color.my.red,
    diag_hint = my.color.my.yellow,
    diag_info = my.color.my.aqua,
    git_del = my.color.my.red,
    git_add = my.color.my.green,
    git_change = my.color.my.yellow
  }
end
local ArrowLeftLeft = {
  hl = function(self) return { fg = my.color.my.magenta, bg = vimode_color() } end,
  provider = ""
}
local ArrowRightLeft = {
  hl = function(self) return { bg = my.color.my.magenta, fg = vimode_color(), force = true } end,
  ArrowLeftLeft,
}
local ArrowRightRight = {
  hl = { fg = my.color.my.magenta, bg = "vimode" },
  provider = ""
}
local ArrowLeftRight = {
  hl = function(self) return { bg = my.color.my.magenta, fg = vimode_color(), force = true } end,
  ArrowRightRight,
}
local SlantRightRight = {
  hl = { fg = "magenta", bg = "vimode" },
  provider = ""
}
local SlantRightLeft = {
  hl = { fg = "vimode", bg = "magenta" },
  provider = ""
}
local SlantLeftLeft = {
  hl = { fg = "magenta", bg = "vimode" },
  provider = ""
}
local SlantLeftRight = {
  hl = { fg = "vimode", bg = "magenta" },
  provider = ""
}

local Space = { provider = " " }

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode()
  end,
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
  },
  provider = function(self)
    return self.mode_names[self.mode]
  end,
  hl = function(self)
    return { fg = "dark", bg = "magenta", bold = true }
  end,
  -- update = {
  --     "ModeChanged",
  --     callback = function()
  --         vim.cmd("redrawstatus")
  --     end,
  -- },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIconBare = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
}

FileIcon = {
  FileIcon,
  hl = { fg = "dark", bg = "magenta" },
}

local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    self.shortened = false
    if self.lfilename == "" then
      self.lfilename = "[No Name]"
    end
    if not conditions.width_percent_below(#self.lfilename, 0.27) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
      self.shortened = true
    end
  end,
  {
    hl = { fg = "dark", bg = "magenta" },
    provider = function(self)
      return self.lfilename
    end,
  },
  on_click = {
    name = "heirline_filename_ranger_current",
    callback = function()
      require('ranger-nvim').open(true)
    end
  }
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return " [+]"
      end
    end,
    hl = { fg = "green" },
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return " "
      end
    end,
    hl = { fg = "red" },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      return { fg = my.color.my.aqua, bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(FileNameBlock, { provider = " " }, FileIcon, utils.insert(FileNameModifer, FileName),
  unpack(FileFlags))

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = "dark" },
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= "utf-8" and enc:upper()
  end,
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= "unix" and fmt:upper()
  end,
}

local FileSize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { "b", "k", "M", "G", "T", "P", "E" }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize <= 0 then
      return "0" .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
  end,
}

local FileLastModified = {
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date("%c", ftime)
  end,
}

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
}

local ScrollBar = {
  static = {
    sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "magenta", bg = "current_bg" },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },

  provider = " LSP",

  -- Or complicate things a bit and get the servers names
  -- provider  = function(self)
  --     local names = {}
  --     for i, server in ipairs(vim.lsp.buf_get_clients(0)) do
  --         table.insert(names, server.name)
  --     end
  --     return " [" .. table.concat(names, " ") .. "]"
  -- end,
  hl = { fg = "green", bg = "magenta", bold = true },
  on_click = {
    name = "heirline_LSP",
    callback = function()
      vim.defer_fn(function()
        vim.cmd("LspInfo")
      end, 100)
    end,
  },
}

local Dropbar = {
  condition = function(self)
    self.data = vim.tbl_get(dropbar.bars or {}, vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
    return self.data
  end,
  static = { dropbar_on_click_string = 'v:lua.dropbar.on_click_callbacks.buf%s.win%s.fn%s' },
  init = function(self)
    local components = self.data.components
    local children = {}
    for i, c in ipairs(components) do
      local child = {
        {
          provider = c.icon,
          hl = c.icon_hl
        },
        {
          hl = c.name_hl,
          provider = c.name,
        },
        on_click = {
          callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i),
          name = "heirline_dropbar",
        },
      }
      if i < #components then
        local sep = self.data.separator
        table.insert(child, {
          provider = sep.icon,
          hl = sep.icon_hl,
          on_click = {
            callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i + 1)
          }
        })
      end
      table.insert(children, child)
    end
    self.child = self:new(children, 1)
  end,
  provider = function(self) return self.child:eval() end,
  hl = { fg = my.color.my.dark, bg = my.color.my.magenta, force = true },
}

local Navic = {
  condition = function(self) return require("nvim-navic").is_available(vim.api.nvim_get_current_buf()) end,
  static = {
    -- create a type highlight map
    type_hl = {
      File = "Directory",
      Module = "@include",
      Namespace = "@namespace",
      Package = "@include",
      Class = "@structure",
      Method = "@method",
      Property = "@property",
      Field = "@field",
      Constructor = "@constructor",
      Enum = "@field",
      Interface = "@type",
      Function = "@function",
      Variable = "@variable",
      Constant = "@constant",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@field",
      Object = "@type",
      Key = "@keyword",
      Null = "@comment",
      EnumMember = "@field",
      Struct = "@structure",
      Event = "@keyword",
      Operator = "@operator",
      TypeParameter = "@type",
    },
    -- bit operation dark magic, see below...
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    -- create a child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          -- escape `%`s (elixir) and buggy default separators
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
          -- highlight icon only or location name as well
          -- hl = self.type_hl[d.type],

          on_click = {
            -- pass the encoded position through minwid
            minwid = pos,
            callback = function(_, minwid)
              -- decode
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            name = "heirline_navic",
          },
        },
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = " > ",
          hl = { fg = 'bright_fg' },
        })
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self.child = self:new(children, 1)
  end,
  -- evaluate the children containing navic components
  provider = function(self)
    return self.child:eval()
  end,
  hl = { fg = my.color.my.dark },
  update = { "CursorMoved", "ModeChanged" }
}

local BufferDiagnostics = {
  condition = conditions.has_diagnostics,
  update = { "DiagnosticChanged", "BufEnter" },
  on_click = {
    callback = function()
      vim.cmd([[TroubleToggle document_diagnostics]])
    end,
    name = "heirline_diagnostics",
  },

  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError").text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn").text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo").text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint").text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  {
    provider = function(self)
      return self.errors > 0 and ((self.error_icon or " ") .. self.errors .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.red, 33) },
  },
  {
    provider = function(self)
      return self.warnings > 0 and ((self.warn_icon or " ") .. self.warnings .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.orange, 33) },
  },
  {
    provider = function(self)
      return self.info > 0 and ((self.info_icon or "") .. self.info .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.aqua, 33) },
  },
  {
    provider = function(self)
      return self.hints > 0 and ((self.hint_icon or "☉") .. self.hints)
    end,
    hl = { fg = my.color.util.darken(my.color.my.green, 33) },
  },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  update = { "DiagnosticChanged", "TabEnter" },
  on_click = {
    callback = function()
      vim.cmd([[TroubleToggle workspace_diagnostics]])
    end,
    name = "heirline_diagnostics",
  },

  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError").text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn").text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo").text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint").text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO })
  end,

  {
    provider = function(self)
      return self.errors > 0 and ((self.error_icon or " ") .. self.errors .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.red, 33) },
  },
  {
    provider = function(self)
      return self.warnings > 0 and ((self.warn_icon or " ") .. self.warnings .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.orange, 33) },
  },
  {
    provider = function(self)
      return self.info > 0 and ((self.info_icon or "") .. self.info .. " ")
    end,
    hl = { fg = my.color.util.darken(my.color.my.aqua, 33) },
  },
  {
    provider = function(self)
      return self.hints > 0 and ((self.hint_icon or "☉") .. self.hints)
    end,
    hl = { fg = my.color.util.darken(my.color.my.green, 33) },
  },
}

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  on_click = {
    callback = function(self, minwid, nclicks, button)
      vim.cmd("Neogit")
    end,
    name = "heirline_git",
    update = false,
  },
  hl = { fg = "dark", bg = "magenta" },
  Space,
  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  Space,
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "[",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = "green" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = "red" }
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = "orange" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "]",
  },
  Space,
}

local Snippets = {
  condition = function()
    return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
  end,
  provider = function()
    local forward = (vim.fn["UltiSnips#CanJumpForwards"]() == 1) and "" or ""
    local backward = (vim.fn["UltiSnips#CanJumpBackwards"]() == 1) and "" or ""
    return backward .. forward
  end,
  hl = { fg = "red", bold = true },
}

-- local DAPMessages = {
--   condition = function()
--     local session = require("dap").session()
--     if session then
--       local filename = vim.api.nvim_buf_get_name(0)
--       if session.config then
--         local progname = session.config.program
--         return filename == progname
--       end
--     end
--     return false
--   end,
--   provider = function()
--     return " " .. require("dap").status()
--   end,
--   hl = "Debug",
--   --       ﰇ  
-- }

-- local UltTest = {
--     condition = function()
--         return vim.api.nvim_call_function("ultest#is_test_file", {}) ~= 0
--     end,
--     static = {
--         passed_icon = vim.fn.sign_getdefined("test_pass")[1].text,
--         failed_icon = vim.fn.sign_getdefined("test_fail")[1].text,
--         passed_hl = { fg = utils.get_highlight("UltestPass").fg },
--         failed_hl = { fg = utils.get_highlight("UltestFail").fg },
--     },
--     init = function(self)
--         self.status = vim.api.nvim_call_function("ultest#status", {})
--     end,
--     {
--         provider = function(self)
--             return self.passed_icon .. self.status.passed .. " "
--         end,
--         hl = function(self)
--             return self.passed_hl
--         end,
--     },
--     {
--         provider = function(self)
--             return self.failed_icon .. self.status.failed .. " "
--         end,
--         hl = function(self)
--             return self.failed_hl
--         end,
--     },
--     {
--         provider = function(self)
--             return "of " .. self.status.tests - 1
--         end,
--     },
-- }

local WorkDir = {
  provider = function(self)
    self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { fg = "dark", bold = true },
  on_click = {
    callback = function()
      require 'ranger-nvim'.open(false)
    end,
    name = "heirline_workdir",
  },

  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. self.cwd:gsub("~/.local/git", "") .. trail .. " "
    end,
  },
  --{
  --  provider = function(self)
  --    local cwd = vim.fn.pathshorten(self.cwd)
  --    local trail = self.cwd:sub(-1) == "/" and "" or "/"
  --    return self.icon .. cwd .. trail .. " "
  --  end,
  --},
}

local HelpFilename = {
  condition = function()
    return vim.bo.filetype == "help"
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ":t")
  end,
  hl = { fg = "current_fg" },
}

local TerminalName = {
  -- icon = ' ', -- 
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      return " " .. tname
    end,
    hl = { fg = "blue", bold = true },
  },
  { provider = " - " },
  {
    provider = function()
      return vim.b.term_title
    end,
  },
  {
    provider = function()
      local id = require("terminal"):current_term_index()
      return " " .. (id or "Exited")
    end,
    hl = { bold = true, fg = "blue" },
  },
}

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = "SPELL ",
  hl = { bold = true, fg = "yellow" },
}

local Align = { provider = "%=" }

local DefaultStatusline = {
  ViMode,
  ArrowRightRight,
  Space,
  Spell,
  {
    hl = { bg = "magenta" },
    {
      hl = function(self) return { bg = my.color.my.magenta, fg = vimode_color(), force = true } end,
      ArrowRightRight,
    },
    Space,
    WorkDir,
    ArrowRightRight,
  },
  Space,
  {
    hl = { bg = "magenta" },
    ArrowLeftRight,
    Git,
    ArrowRightRight,
  },
  Space,
  {
    hl = { bg = my.color.my.red, bold = true },
    condition = conditions.has_diagnostics,
    {
      hl = function(self) return { fg = my.color.my.red, bg = vimode_color(), force = true } end,
      ArrowLeftLeft,
      update = "ModeChanged"
    },
    Space,
    Diagnostics,
    Space,
    {
      hl = function(self) return { fg = my.color.my.red, bg = vimode_color(), force = true } end,
      ArrowRightRight,
      update = "ModeChanged"
    },
    update = "ModeChanged"
  },
  Align,
  -- DAPMessages,
  ArrowLeftLeft,
  {
    hl = { bg = "magenta", force = true },
    Space,
    LSPActive,
    Space,
  },
  ArrowRightLeft,
  -- UltTest,
  Space,
  {
    hl = { bg = "magenta" },
    ArrowLeftLeft,
    Space,
    FileType,
    Space,
    ArrowRightLeft,
  },
  Space,
  {
    hl = { bg = "magenta" },
    ArrowLeftLeft,
    Space,
    FileEncoding,
    FileLastModified,
    Space,
    ArrowRightLeft,
  },
  Space,
  {
    hl = { bg = "magenta" },
    ArrowLeftLeft,
    Space,
    Ruler,
  },
  ScrollBar,
  update = { "VimEnter", "ModeChanged" }
}

local InactiveStatusline = {
  condition = function()
    return not conditions.is_active()
  end,
  { hl = { fg = "gray", force = true }, WorkDir },
  FileNameBlock,
  { provider = "%<" },
  Align,
}

local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "^git.*", "fugitive" },
    })
  end,
  FileType,
  { provider = "%q" },
  Space,
  HelpFilename,
  Align,
}

local GitStatusline = {
  condition = function()
    return conditions.buffer_matches({
      filetype = { "^git.*", "fugitive" },
    })
  end,
  FileType,
  Space,
  {
    provider = function()
      return vim.fn.FugitiveStatusline()
    end,
  },
  Space,
  Align,
}

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,
  hl = { bg = "magenta" },
  { condition = conditions.is_active, ViMode, Space },
  FileType,
  Space,
  -- TerminalName,
  Align,
}

local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return { bg = vimode_color() }      -- "StatusLine"
    else
      return { bg = my.color.my.magenta } -- "StatusLineNC"
    end
  end,
  static = {
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or "n"
      local current_mode_color = vimode_color()

      vim.api.nvim_set_hl(0, "StatusLine", { bg = current_mode_color })
      return current_mode_color
    end,
  },

  update = { "DirChanged", "VimEnter", "ColorScheme", "ModeChanged", "WinNew" },
  fallthrough = false,
  GitStatusline,
  SpecialStatusline,
  TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

local CloseButton = {
  condition = function(self)
    return not vim.bo.modified
  end,
  -- update = 'BufEnter',
  update = { "WinNew", "WinClosed", "BufEnter" },
  { provider = " " },
  {
    provider = "",
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, winid)
        vim.api.nvim_win_close(winid, true)
      end,
      name = function(self)
        return "heirline_close_button_" .. self.winnr
      end,
      update = true,
    },
  },
}

local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. ". "
  end,
  hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active, italic = self.is_active or self.is_visible }
  end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    provider = "[+]",
    hl = { fg = my.color.my.yellow },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
          or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
        return "  "
      else
        return ""
      end
    end,
    hl = { fg = my.color.my.yellow, bg = my.color.my.black },
  },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active or self.is_visible then
      return { fg = my.color.my.yellow }
    elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      return { fg = "gray" }
    else
      return {}
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if (button == "m") then -- close on mouse middle click
        vim.api.nvim_buf_delete(minwid, { force = false })
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  TablineBufnr,
  {
    FileIconBare,
    hl = function(self)
      return self.is_active and { fg = my.color.my.magenta } or
          self.is_visible and { fg = my.color.my.dark } or
          { fg = my.color.util.darken(my.color.my.light, 50) }
    end,
  },
  TablineFileName,
  TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
  condition = function(self)
    return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
  end,
  { provider = " " },
  {
    provider = "",
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.cmd("bp|bd " .. minwid)
        -- vim.api.nvim_buf_delete(minwid, { force = false })
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_close_buffer_callback",
    },
  },
  { provider = " " },
}

local TablinePicker = {
  condition = function(self)
    return self._show_picker
  end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ":t")
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      if i > #bufname then
        break
      end
      label = bufname:sub(i, i)
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self)
    return " " .. self.label
  end,
  hl = { fg = "red", bold = true },
}

-- The final touch!
local TablineBufferBlock = utils.surround(
  { "", "" },
  function(self)
    if self.is_active then
      return my.color.my.vimode[vim.fn.mode()]
    elseif self.is_visible then
      return my.color.util.desaturate(
        my.color.my.vimode[vim.fn.mode()],
        50
      )
    else
      return my.color.util[vim.opt.background:get() == "light" and "darken" or "lighten"](my.color.util.desaturate(my
        .color
        .int_to_hex(utils.get_highlight("TabLine")
          .bg), 73), 73)
    end
  end, {
    TablineFileNameBlock,
    TablinePicker,
    TablineCloseButton
  })

-- and here we go
local Tabpage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
  end,
  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return { bg = my.color.my.vimode[vim.fn.mode()] }
    end
  end,
}

local TabpageClose = {
  provider = "%999X  %X",
  hl = "TabLine",
}

local TabPages = {
  -- only show this component if there's 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = "%=" },
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == "NvimTree" then
      self.title = "NvimTree"
      return true
      -- elseif vim.bo[bufnr].filetype == "TagBar" then
      --     ...
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return "TablineSel"
    else
      return "Tabline"
    end
  end,
}

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = "  ", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
  { provider = "  ", hl = { fg = "gray" } },
  -- right trunctation, also optional (defaults to ...... yep, ">")
  function(self)
    return vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_get_name(bufnr):find(vim.fn.getcwd(), 0, true)
    end, vim.api.nvim_list_bufs())
  end
-- by the way, open a lot of buffers and try clicking them ;)
)

local TabLine = {
  TabLineOffset,
  BufferLine,
  TabPages,
  hl = { bg = my.color.my.magenta },
  update = { "DirChanged", "BufLeave", "BufEnter", "ModeChanged", "BufModifiedSet", "TabEnter", "OptionSet", "WinNew" }
}

local WinBar = {
  -- hl = function()
  --   if conditions.is_active() then
  --     return "StatusLine"
  --   else
  --     return "WinBarNC"
  --   end
  -- end,
  -- {
  --   hl = { fg = my.color.my.dark, bg = my.color.my.magenta, force = true },
  --   Space,
  --   FileNameBlock,
  --   Space,
  -- },
  {
    -- flexible = 1,
    condition = function()
      if require('nvim-navic').is_available(vim.api.nvim_get_current_buf()) then
        local data = require('nvim-navic').get_data()
        local data_len = 0

        for _, _ in pairs(data or {}) do
          data_len = data_len + 1
        end

        return data_len > 0
      end

      return false
    end,
    hl = function()
      -- if conditions.is_active() and vim.fn.mode() ~= "n" then
      --   return { fg = my.color.my.dark, bg = my.color.my.magenta, force = true }
      -- end

      return { fg = my.color.my.dark, bg = my.color.my.magenta } --, bold = true, force = true }
    end,
    Space,
    {
      condition = function(self) return require("nvim-navic").is_available(vim.api.nvim_get_current_buf()) end,
      Dropbar
    },
    {
      condition = function(self) return not require("nvim-navic").is_available(vim.api.nvim_get_current_buf()) end,
      FileNameBlock
    },
    Space,
    -- {
    --   provider = "",
    -- },
  },
  {
    hl = function(self) return { fg = my.color.my.magenta, bg = vimode_color(), force = true } end,
    provider = ""
  },
  Align,
  {
    condition = conditions.has_diagnostics,
    hl = function(self)
      if (not conditions.is_active()) then
        return { fg = my.color.my.light, bg = my.color.my.red }
      end

      return { bg = my.color.my.red, bold = true }
    end,
    {
      hl = function(self) return { fg = my.color.my.red, bg = vimode_color(), force = true } end,
      provider = function(self) return "" end,
      update = { "ModeChanged" }
    },
    Space,
    BufferDiagnostics,
    Space,
    {
      hl = { fg = my.color.my.red, bg = "vimode", force = true },
      provider = function(self) return "" end,
      update = { "ModeChanged" }
    },
    update = { "CursorMoved", "ModeChanged" }
  },
  Space,
  {
    hl = { fg = my.color.my.magenta, bg = "vimode", force = true },
    provider = "",
    update = { "ModeChanged" }
  },
  {
    hl = { fg = my.color.my.dark, bg = my.color.my.magenta },
    provider = function(self)
      return " #" .. self.winnr
    end
  },
  update = { "CursorMoved", "ModeChanged" }
}

local WinBars = {
  fallthrough = false,
  {
    condition = function()
      return (not conditions.buffer_matches({
            filetype = { "lua", "clojure", "clojurescript", "clj", "cljs", "ts", "tsx", "typescript", "typescriptreact",
              "js",
              "jsx", "javascript", "javascriptreact", "html", "css", "json", "md", "sass", "less", "yml", "yaml" },
          }))
          or conditions.buffer_matches({
            buftype = { ".*git.*", "terminal", "nofile", "prompt", "help", "quickfix" },
            filetype = { "wilder", "packer", "neo-tree", "which-key", "Diffview.*", "NeogitStatus", ".*git.*", "^git.*",
              "fugitive" },
          })
    end,
    init = function()
      -- vim.opt_local.winbar = nil
    end,
  },
  WinBar,
  update = { "ModeChanged", "VimEnter", "ColorScheme", "WinNew", "OptionSet" }
}

local M = {}

function M.update()
  -- require("heirline").tabline:broadcast(function(self)
  --   self._win_ttl = nil
  -- end)
  require("heirline").statusline:broadcast(function(self)
    self._win_stl = nil
  end)
  require("heirline.utils").on_colorscheme(setup_colors())
  vim.api.nvim_set_hl(0, "StatusLine",
    { bg = my.color.my.vimode[vim.fn.mode() or "n"] }
  )
  vim.api.nvim_set_hl(0, "ScrollbarHandle", { bg = my.color.my.vimode[vim.fn.mode() or "n"] })
end

function M.aucmds()
  vim.api.nvim_create_augroup("Heirline", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "HeirlineInitWinbar",
    callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains({ "terminal", "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
      local filetype = vim.tbl_contains({ "wilder", "packer", "which-key", "Diffview.*", "NeogitStatus", "gitcommit",
        "fugitive" }, vim.bo[buf].filetype)
      if buftype or filetype then
        vim.opt_local.winbar = nil
      end
    end,
    group = "Heirline",
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = M.update,
    group = "Heirline",
  })
end

function M.load_colors()
  require("heirline").load_colors(setup_colors())
end

function M.setup(my_aucmds)
  require("heirline").load_colors(setup_colors())
  vim.api.nvim_set_hl(0, "TabLine", { bg = my.color.my.magenta })
  vim.api.nvim_set_hl(0, "TabLineSel", { bg = my.color.my.magenta })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = my.color.my.magenta })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = vimode_color() })
  vim.api.nvim_set_hl(0, "WinBar", { bg = vimode_color() })
  require("heirline").setup({
    statusline = StatusLines,
    winbar = WinBars,
  })

  if my_aucmds == true then
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
    M.aucmds()
  end
end

M.StatusLines = StatusLines
M.WinBars = WinBars

return M
