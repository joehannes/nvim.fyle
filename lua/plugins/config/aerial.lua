---@diagnostic disable: undefined-global
local config = {}

vim.cmd([[
hi link AerialClass Type
hi link AerialClassIcon Special
hi link AerialFunction Special
hi AerialFunctionIcon guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi link AerialLine QuickFixLine
]])

function config.setup()
  require("aerial").setup({
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { "treesitter", "lsp", "markdown" },

    -- Enum: persist, close, auto, global
    --   persist - aerial window will stay open until closed
    --   close   - aerial window will close when original file is no longer visible
    --   auto    - aerial window will stay open as long as there is a visible
    --             buffer to attach to
    --   global  - same as 'persist', and will always show symbols for the current buffer
    close_behavior = "global",

    -- Set to false to remove the default keybindings for the aerial buffer
    default_bindings = true,

    -- Enum: prefer_right, prefer_left, right, left, float
    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    default_direction = "left",

    -- Disable aerial on files with this many lines
    disable_max_lines = 10000,

    -- A list of all symbols to display. Set to false to display all symbols.
    -- This can be a filetype map (see :help aerial-filetype-map)
    -- To see all available values, see :help SymbolKind
    filter_kind = false,

    -- Enum: split_width, full_width, last, none
    -- Determines line highlighting mode when multiple splits are visible
    -- split_width   Each open window will have its cursor location marked in the
    --               aerial buffer. Each line will only be partially highlighted
    --               to indicate which window is at that location.
    -- full_width    Each open window will have its cursor location marked as a
    --               full-width highlight in the aerial buffer.
    -- last          Only the most-recently focused window will have its location
    --               marked in the aerial buffer.
    -- none          Do not show the cursor locations in the aerial window.
    highlight_mode = "full_width",

    -- Highlight the closest symbol if the cursor is not exactly on one.
    highlight_closest = true,

    -- Highlight the symbol in the source buffer when cursor is in the aerial win
    highlight_on_hover = false,
    -- When jumping to a symbol, highlight the line for this many ms.
    -- Set to false to disable
    highlight_on_jump = 300,

    ignore = {
      -- Ignore unlisted buffers. See :help buflisted
      unlisted_buffers = true,

      -- List of filetypes to ignore.
      filetypes = {},

      -- Ignored buftypes.
      -- Can be one of the following:
      -- false or nil - No buftypes are ignored.
      -- "special"    - All buffers other than normal buffers are ignored.
      -- table        - A list of buftypes to ignore. See :help buftype for the
      --                possible values.
      -- function     - A function that returns true if the buffer should be
      --                ignored or false if it should not be ignored.
      --                Takes two arguments, `bufnr` and `buftype`.
      buftypes = "special",

      -- Ignored wintypes.
      -- Can be one of the following:
      -- false or nil - No wintypes are ignored.
      -- "special"    - All windows other than normal windows are ignored.
      -- table        - A list of wintypes to ignore. See :help win_gettype() for the
      --                possible values.
      -- function     - A function that returns true if the window should be
      --                ignored or false if it should not be ignored.
      --                Takes two arguments, `winid` and `wintype`.
      wintypes = "special",
    },
    -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
    -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
    -- default collapsed icon. The default icon set is determined by the
    -- "nerd_font" option below.
    -- If you have lspkind-nvim installed, aerial will use it for icons.
    -- icons = {},

    -- When you fold code with za, zo, or zc, update the aerial tree as well.
    -- Only works when manage_folds = true
    link_folds_to_tree = false,

    -- Fold code when you open/collapse symbols in the tree.
    -- Only works when manage_folds = true
    link_tree_to_folds = true,

    -- Use symbol tree for folding. Set to true or false to enable/disable
    -- 'auto' will manage folds if your previous foldmethod was 'manual'
    manage_folds = false,

    -- The maximum width of the aerial window
    max_width = 50,

    -- The minimum width of the aerial window.
    -- To disable dynamic resizing, set this to be equal to max_width
    min_width = 30,

    -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
    -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
    nerd_font = "auto",

    -- Call this function when aerial attaches to a buffer.
    -- Useful for setting keymaps. Takes a single `bufnr` argument.
    on_attach = nil,

    -- Automatically open aerial when entering supported buffers.
    -- This can be a function (see :help aerial-open-automatic)
    open_automatic = true,

    -- Set to true to only open aerial at the far right/left of the editor
    -- Default behavior opens aerial relative to current window
    placement_editor_edge = true,

    -- Run this command after jumping to a symbol (false will disable)
    post_jump_cmd = "normal! zz",

    -- When true, aerial will automatically close after jumping to a symbol
    close_on_select = false,

    -- Show box drawing characters for the tree hierarchy
    show_guides = false,

    -- The autocmds that trigger symbols update (not used for LSP backend)
    update_events = "TextChanged,InsertLeave",

    -- Customize the characters used when show_guides = true
    guides = {
      -- When the child item has a sibling below it
      mid_item = "├─",
      -- When the child item is the last in the list
      last_item = "└─",
      -- When there are nested child guides to the right
      nested_top = "│ ",
      -- Raw indentation
      whitespace = "  ",
    },
    -- Options for opening aerial in a floating win
    float = {
      -- Controls border appearance. Passed to nvim_open_win
      border = "rounded",

      -- The maximum height of the floating aerial window
      max_height = 100,

      -- The minimum height of the floating aerial window
      -- To disable dynamic resizing, set this to be equal to max_height
      min_height = 4,
    },

    lsp = {
      -- Fetch document symbols when LSP diagnostics change.
      -- If you set this to false, you will need to manually fetch symbols
      diagnostics_trigger_update = true,

      -- Set to false to not update the symbols when there are LSP errors
      update_when_errors = true,

      update_delay = 100,
    },

    treesitter = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 100,
    },

    markdown = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },
  })
end

return config
