---@diagnostic disable:undefined-global
local root_pattern = require("lspconfig.util").root_pattern
local on_attach = require("lang/attach")
local capabilities = require("lang/capabilities")

local setup = {}
local sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin"
local sumneko_binary = sumneko_root_path .. "/lua-language-server"

function setup.diagnostic()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.minimal,
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    -- root_dir = root_pattern("tsconfig.json", ".eslintrc.json", "package.json", ".git"),
    init_options = {
      filetypes = {
        javascript = "eslint",
        typescript = "eslint",
        javascriptreact = "eslint",
        typescriptreact = "eslint",
      },
      linters = {
        eslint = {
          sourceName = "eslint",
          command = "eslint_d",
          rootPatterns = {
            ".eslintrc.js",
            ".eslintrc.json",
            ".eslintrc",
            "package.json",
          },
          debounce = 100,
          args = {
            "--cache",
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json",
          },
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity",
          },
          securities = {
            [2] = "error",
            [1] = "warning",
          },
        },
      },
    },
  }

  return opts
end

function setup.eslint()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.minimal,
    settings = {
      format = { enable = false }, -- this will enable formatting
    },
  }

  return opts
end

function setup.json()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.generic,
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            fileMatch = { "now.json", "vercel.json" },
            url = "https://json.schemastore.org/now.json",
          },
          {
            fileMatch = { "ecosystem.json" },
            url = "https://json.schemastore.org/pm2-ecosystem.json",
          },
        },
      },
    },
  }

  return opts
end

function setup.typescript()
  local opts = {
    capabilities = capabilities,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
    on_attach = on_attach.typescript,
    settings = {
      format = { enable = true },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }
  }

  return opts
end

function setup.clojure()
  local opts = {
    capabilities = capabilities,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
    on_attach = on_attach.clojure,
    settings = {
      format = { enable = true },
      filetypes = { "clojure", "clojurescript", "clojuredart", "edn" },
    }
  }

  return opts
end

function setup.rust_analyzer()
  local opts = {
    capabilities = capabilities,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
    on_attach = on_attach.generic,
    settings = {
      format = { enable = true },
    }
  }

  return opts
end

function setup.python()
  local opts = {
    capabilities = capabilities,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
    on_attach = on_attach.python,
    settings = {
      format = { enable = true },
      pyright = {
        disableOrganizeImports = false,
        analysis = {
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
        }
      }
    }
  }

  return opts
end

function setup.lua()
  local opts = {
    -- require("neodev").setup({
    -- library = { vimruntime = true, types = true, plugins = true },
    -- lspconfig = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach.lua(client, bufnr)
      require("lsp-format").on_attach(client)
    end,
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
      format = { enable = true }, -- this will enable formatting
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/config")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/lang")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/statusline")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/utils")] = true,
          },
        },
        completion = {
          callSnippet = "Replace"
        },
      },
    },
  }

  return opts
end

function setup.css()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.minimal,
    settings = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      -- root_dir = root_pattern("package.json", ".git"),
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  }

  return opts
end

function setup.cssmodules()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.minimal,
    settings = {
      cmd = { "cssmodules-language-server" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      -- root_dir = root_pattern("package.json", ".git"),
    },
  }

  return opts
end

function setup.efm()
  local efmls             = require("efmls-configs")
  local efm_fs            = require("efmls-configs.fs")
  local root_path         = vim.api.nvim_call_function("getcwd", {})

  local eslint_cfg_path   = table.foreach({
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
  }, function(_, value)
    return my.fs.exists(root_path .. "/" .. value) and root_path .. "/" .. value or nil
  end) or root_path .. "/package.json"
  local prettier_cfg_path = table.foreach({
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.config.js",
    ".prettierrc.config.cjs",
    ".prettierrc.toml",
  }, function(_, value)
    return my.fs.exists(root_path .. "/" .. value) and root_path .. "/" .. value or nil
  end) or root_path .. "/package.json"
  local stylelint         = require("efmls-configs.linters.stylelint")
  local eslint            = require("efmls-configs.linters.eslint_d")
  -- eslint.lintCommand      = eslint.lintCommand .. " --rule 'prettier/prettier: off'"
  -- local luacheck = require("efmls-configs.linters.luacheck")
  local prettier_default  = require 'efmls-configs.formatters.prettier'
  local prettier          = {
    formatCommand = string.format('%s --stdin --stdin-filepath ${INPUT}' ..
      ' --eslint-config-path ' .. eslint_cfg_path .. ' --config ' .. prettier_cfg_path,
      efm_fs.executable('prettier-eslint', efm_fs.Scope.NODE)),
    formatStdin = true,
  }
  -- local clj_kondo         = require 'efmls-configs.linters.clj_kondo'
  local clj_kondo         = require 'plugins/config/clj_kondo'
  local joker             = require 'efmls-configs.formatters.joker'

  local handlers          = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virutal_text = true,
      underline = true,
      signs = true,
      update_in_insert = false,
    })
  }

  local init_opts         = {
    on_attach = on_attach.minimal,
    handlers = handlers,
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    },
  }

  local languages         = {
    css = {
      linter = stylelint,
      formatter = prettier_default,
    },
    scss = {
      linter = stylelint,
      formatter = prettier_default,
    },
    javascript = {
      linter = eslint,
      formatter = prettier,
    },
    javascriptreact = {
      linter = eslint,
      formatter = prettier,
    },
    typescript = {
      linter = eslint,
      formatter = prettier,
    },
    typescriptreact = {
      linter = eslint,
      formatter = prettier,
    },
    -- clojure = {
    --   linter = clj_kondo,
    --   formatter = joker,
    -- },
  };

  return vim.tbl_extend('force', init_opts, {
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = { '.git/' },
      languages = languages,
    },
  });
end

function setup.generic()
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach.minimal,
    settings = {
      format = { enable = false }, -- this will enable formatting
      -- root_dir = root_pattern("tsconfig.json", ".eslintrc.json", "package.json", ".git"),
    },
    autostart = true,
  }

  return opts
end

function setup.null()
  local ls = require("null-ls")

  ls.setup({
    sources = {
      ls.builtins.diagnostics.eslint_d,
      ls.builtins.code_actions.eslint_d,
      ls.builtins.formatting.prettier
    },
    on_attach = on_attach.null_ls,
    update_in_insert = true,
  })
end

return setup
