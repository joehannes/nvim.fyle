local M = {}

function M.setup()
  require("themer").setup({
    transparent = false,
    dim_inactive = true,
    enable_installer = true,
    styles = {
      comment = {},
      ["function"] = { style = "italic" },
      functionBuiltIn = { style = "italic,bold" },
      operator = { style = "bold" },
      variable = { style = "italic" },
      variableBuiltIn = { style = "italic,bold" },
      parameter = { style = "italic" },
      conditional = { style = "bold" },
      include = { style = "bold" },
      keyword = { style = "bold" },
      keywordBuiltIn = { style = "bold" },
    },
    remaps = {
      highlights = {
        globals = {
          ["cursorlinenr"] = { underline = false }
        }
      }
    }
  })
end

return M
