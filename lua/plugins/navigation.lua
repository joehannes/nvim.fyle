return {
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = true,
        mappings = {
          annotate = "m@",
          m0 = false,
          m1 = false,
          m2 = false,
          m3 = false,
          m4 = false,
          m5 = false,
          m6 = false,
          m7 = false,
          m8 = false,
          m9 = false,
        },
        bookmark_0 = {
          sign = "",
          virt_text = " ( 0) ",
        },
        bookmark_1 = {
          sign = "",
          virt_text = " ( 1) ",
        },
        bookmark_2 = {
          sign = "",
          virt_text = " ( 2) ",
        },
        bookmark_3 = {
          sign = "",
          virt_text = " ( 3) ",
        },
        bookmark_4 = {
          sign = "",
          virt_text = " ( 4) ",
        },
        bookmark_5 = {
          sign = "",
          virt_text = " ( 5) ",
        },
        bookmark_6 = {
          sign = "",
          virt_text = " ( 6) ",
        },
        bookmark_7 = {
          sign = "",
          virt_text = " ( 7) ",
        },
        bookmark_8 = {
          sign = "",
          virt_text = " ( 8) ",
        },
        bookmark_9 = {
          sign = "",
          virt_text = " ( 9) ",
        },
      })
    end,
  },
  {
    "cbochs/portal.nvim",
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon"
    },
    config = function() require("plugins.config.portal").setup() end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    as = "hop",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection

      hop.setup({ keys = "etovxqpdygfblzhckisuran" })

      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end,
  },
  -- {
  --   'jinh0/eyeliner.nvim',
  --   config = function()
  --     require 'eyeliner'.setup {
  --       highlight_on_key = true, -- show highlights only after keypress
  --       dim = true               -- dim all other characters if set to true (recommended!)
  --     }
  --   end
  -- },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("plugins.config.navbuddy").setup()
    end,
  },
  {
    "LeonHeidelbach/trailblazer.nvim",
    config = function()
      require("trailblazer").setup({
        {
          lang = "en",
          auto_save_trailblazer_state_on_exit = true,
          auto_load_trailblazer_state_on_enter = true,
          custom_session_storage_dir = "~/.local/share/nvim/sessions/", -- i.e. "~/trail_blazer_sessions/"
          trail_options = {
            -- The trail mark priority sets the global render priority of trail marks in the sign/number
            -- column as well as the highlights within the text (e.g. Treesitter sets a value of 100).
            -- Make sure this value is higher than any other plugin you use to ensure that trail marks
            -- are always visible and don't get overshadowed.
            trail_mark_priority = 10001,
            -- Available modes to cycle through. Remove any you don't need.
            available_trail_mark_modes = {
              "global_chron",
              "global_buf_line_sorted",
              "global_fpath_line_sorted",
              "global_chron_buf_line_sorted",
              "global_chron_fpath_line_sorted",
              "global_chron_buf_switch_group_chron",
              "global_chron_buf_switch_group_line_sorted",
              "buffer_local_chron",
              "buffer_local_line_sorted"
            },
            -- The current / initially selected trail mark selection mode. Choose from one of the
            -- available modes: global_chron, global_buf_line_sorted, global_chron_buf_line_sorted,
            -- global_chron_buf_switch_group_chron, global_chron_buf_switch_group_line_sorted,
            -- buffer_local_chron, buffer_local_line_sorted
            current_trail_mark_mode = "global_chron",
            current_trail_mark_list_type = "quickfix", -- currently only quickfix lists are supported
            trail_mark_list_rows = 10, -- number of rows to show in the trail mark list
            verbose_trail_mark_select = true, -- print current mode notification on mode change
            mark_symbol = "•", --  will only be used if trail_mark_symbol_line_indicators_enabled = true
            newest_mark_symbol = "🔥", -- disable this mark symbol by setting its value to ""
            cursor_mark_symbol = "⦁", -- disable this mark symbol by setting its value to ""
            next_mark_symbol = "⤷", -- disable this mark symbol by setting its value to ""
            previous_mark_symbol = "⤶", -- disable this mark symbol by setting its value to ""
            multiple_mark_symbol_counters_enabled = true,
            number_line_color_enabled = true,
            trail_mark_in_text_highlights_enabled = true,
            trail_mark_symbol_line_indicators_enabled = false, -- show indicators for all trail marks in symbol column
            symbol_line_enabled = true,
            default_trail_mark_stacks = {
              -- this is the list of trail mark stacks that will be created by default. Add as many
              -- as you like to this list. You can always create new ones in Neovim by using either
              -- `:TrailBlazerSwitchTrailMarkStack <name>` or `:TrailBlazerAddTrailMarkStack <name>`
              "default" -- , "stack_2", ...
            },
            available_trail_mark_stack_sort_modes = {
              "alpha_asc", -- alphabetical ascending
              "alpha_dsc", -- alphabetical descending
              "chron_asc", -- chronological ascending
              "chron_dsc", -- chronological descending
            },
            -- The current / initially selected trail mark stack sort mode. Choose from one of the
            -- available modes: alpha_asc, alpha_dsc, chron_asc, chron_dsc
            current_trail_mark_stack_sort_mode = "chron_asc",
            -- Set this to true if you always want to move to the nearest trail mark first before
            -- continuing to peek move in the current selection mode order. This effectively disables
            -- the "current trail mark cursor" to which you would otherwise move first before continuing
            -- to move through your trail mark stack.
            move_to_nearest_before_peek = false,
            move_to_nearest_before_peek_motion_directive_up = "fpath_up",     -- "up", "fpath_up" -> For more information see section "TrailBlazerMoveToNearest Motion Directives"
            move_to_nearest_before_peek_motion_directive_down = "fpath_down", -- "down", "fpath_down" -> For more information see section "TrailBlazerMoveToNearest Motion Directives"
            move_to_nearest_before_peek_dist_type = "lin_char_dist",          -- "man_dist", "lin_char_dist" -> Manhattan Distance or Linear Character Distance
          },
          event_list = {
            -- Add the events you would like to add custom callbacks for here. For more information see section "Custom Events"
            -- "TrailBlazerTrailMarkStackSaved",
            -- "TrailBlazerTrailMarkStackDeleted",
            -- "TrailBlazerCurrentTrailMarkStackChanged",
            -- "TrailBlazerTrailMarkStackSortModeChanged"
          },
          mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
            nv = {     -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
              motions = {
              },
              actions = {
              },
            },
            -- You can also add/move any motion or action to mode specific mappings i.e.:
            -- i = {
            --     motions = {
            --         new_trail_mark = '<C-l>',
            --         ...
            --     },
            --     ...
            -- },
          },
          quickfix_mappings = { -- rename this to "force_quickfix_mappings" to completely override default mappings and not merge with them
            nv = {
              motions = {
                qf_motion_move_trail_mark_stack_cursor = "<CR>",
              },
              actions = {
                qf_action_delete_trail_mark_selection = "d",
                qf_action_save_visual_selection_start_line = "v",
              },
              alt_actions = {
                qf_action_save_visual_selection_start_line = "V",
              }
            },
            v = {
              actions = {
                qf_action_move_selected_trail_marks_down = "<C-j>",
                qf_action_move_selected_trail_marks_up = "<C-k>",
              }
            }
          },
          -- Your custom highlight group overrides go here
          -- hl_groups = {}
        }
      })
    end,
  },
  -- {
  --   'Bekaboo/dropbar.nvim',
  --   -- optional, but required for fuzzy finder support
  --   dependencies = {
  --     'nvim-telescope/telescope-fzf-native.nvim'
  --   },
  --   config = function()
  --     local sources = require('dropbar.sources')
  --     local utils = require('dropbar.utils')
  --     local opts = {
  --       general = {
  --         ---@type boolean|fun(buf: integer, win: integer): boolean
  --         enable = function(buf, win)
  --           return false
  --               and not vim.api.nvim_win_get_config(win).zindex
  --               and vim.bo[buf].buftype == ''
  --               and vim.api.nvim_buf_get_name(buf) ~= ''
  --               and not vim.wo[win].diff
  --         end,
  --         attach_events = {
  --           'OptionSet',
  --           'BufWinEnter',
  --           'BufWritePost',
  --         },
  --         -- Wait for a short time before updating the winbar, if another update
  --         -- request is received within this time, the previous request will be
  --         -- cancelled, this improves the performance when the user is holding
  --         -- down a key (e.g. 'j') to scroll the window, default to 0 ms
  --         -- If you encounter performance issues when scrolling the window, try
  --         -- setting this option to a number slightly larger than
  --         -- 1000 / key_repeat_rate
  --         update_interval = 0,
  --         update_events = {
  --           win = {
  --             'CursorMoved',
  --             'CursorMovedI',
  --             'WinEnter',
  --             'WinResized',
  --           },
  --           buf = {
  --             'BufModifiedSet',
  --             'FileChangedShellPost',
  --             'TextChanged',
  --             'TextChangedI',
  --           },
  --           global = {
  --             'DirChanged',
  --             'VimResized',
  --           },
  --         },
  --       },
  --       icons = {
  --         enable = true,
  --         kinds = {
  --           use_devicons = true,
  --           symbols = {
  --             Array = '󰅪 ',
  --             Boolean = ' ',
  --             BreakStatement = '󰙧 ',
  --             Call = '󰃷 ',
  --             CaseStatement = '󱃙 ',
  --             Class = ' ',
  --             Color = '󰏘 ',
  --             Constant = '󰏿 ',
  --             Constructor = ' ',
  --             ContinueStatement = '→ ',
  --             Copilot = ' ',
  --             Declaration = '󰙠 ',
  --             Delete = '󰩺 ',
  --             DoStatement = '󰑖 ',
  --             Enum = ' ',
  --             EnumMember = ' ',
  --             Event = ' ',
  --             Field = ' ',
  --             File = '󰈔 ',
  --             Folder = '󰉋 ',
  --             ForStatement = '󰑖 ',
  --             Function = '󰊕 ',
  --             H1Marker = '󰉫 ', -- Used by markdown treesitter parser
  --             H2Marker = '󰉬 ',
  --             H3Marker = '󰉭 ',
  --             H4Marker = '󰉮 ',
  --             H5Marker = '󰉯 ',
  --             H6Marker = '󰉰 ',
  --             Identifier = '󰀫 ',
  --             IfStatement = '󰇉 ',
  --             Interface = ' ',
  --             Keyword = '󰌋 ',
  --             List = '󰅪 ',
  --             Log = '󰦪 ',
  --             Lsp = ' ',
  --             Macro = '󰁌 ',
  --             MarkdownH1 = '󰉫 ', -- Used by builtin markdown source
  --             MarkdownH2 = '󰉬 ',
  --             MarkdownH3 = '󰉭 ',
  --             MarkdownH4 = '󰉮 ',
  --             MarkdownH5 = '󰉯 ',
  --             MarkdownH6 = '󰉰 ',
  --             Method = '󰆧 ',
  --             Module = '󰏗 ',
  --             Namespace = '󰅩 ',
  --             Null = '󰢤 ',
  --             Number = '󰎠 ',
  --             Object = '󰅩 ',
  --             Operator = '󰆕 ',
  --             Package = '󰆦 ',
  --             Pair = '󰅪 ',
  --             Property = ' ',
  --             Reference = '󰦾 ',
  --             Regex = ' ',
  --             Repeat = '󰑖 ',
  --             Scope = '󰅩 ',
  --             Snippet = '󰩫 ',
  --             Specifier = '󰦪 ',
  --             Statement = '󰅩 ',
  --             String = '󰉾 ',
  --             Struct = ' ',
  --             SwitchStatement = '󰺟 ',
  --             Terminal = ' ',
  --             Text = ' ',
  --             Type = ' ',
  --             TypeParameter = '󰆩 ',
  --             Unit = ' ',
  --             Value = '󰎠 ',
  --             Variable = '󰀫 ',
  --             WhileStatement = '󰑖 ',
  --           },
  --         },
  --         ui = {
  --           bar = {
  --             separator = ' ',
  --             extends = '…',
  --           },
  --           menu = {
  --             separator = ' ',
  --             indicator = ' ',
  --           },
  --         },
  --       },
  --       symbol = {
  --         preview = {
  --           ---Reorient the preview window on previewing a new symbol
  --           ---@param _ integer source window id, ignored
  --           ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
  --           reorient = function(_, range)
  --             local invisible = range['end'].line - vim.fn.line('w$') + 1
  --             if invisible > 0 then
  --               local view = vim.fn.winsaveview()
  --               view.topline = view.topline + invisible
  --               vim.fn.winrestview(view)
  --             end
  --           end,
  --         },
  --         jump = {
  --           ---@param win integer source window id
  --           ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
  --           reorient = function(win, range)
  --             local view = vim.fn.winsaveview()
  --             local win_height = vim.api.nvim_win_get_height(win)
  --             local topline = range.start.line - math.floor(win_height / 4)
  --             if
  --                 topline > view.topline
  --                 and topline + win_height < vim.fn.line('$')
  --             then
  --               view.topline = topline
  --               vim.fn.winrestview(view)
  --             end
  --           end,
  --         },
  --       },
  --       bar = {
  --         ---@type dropbar_source_t[]|fun(buf: integer, win: integer): dropbar_source_t[]
  --         sources = function(buf, _)
  --           if vim.bo[buf].ft == 'markdown' then
  --             return {
  --               sources.path,
  --               sources.markdown,
  --             }
  --           end
  --           return {
  --             sources.path,
  --             utils.source.fallback({
  --               sources.lsp,
  --               sources.treesitter,
  --             }),
  --           }
  --         end,
  --         padding = {
  --           left = 1,
  --           right = 1,
  --         },
  --         pick = {
  --           pivots = 'abcdefghijklmnopqrstuvwxyz',
  --         },
  --         truncate = true,
  --       },
  --       menu = {
  --         -- When on, preview the symbol under the cursor on CursorMoved
  --         preview = true,
  --         -- When on, automatically set the cursor to the closest previous/next
  --         -- clickable component in the direction of cursor movement on CursorMoved
  --         quick_navigation = true,
  --         entry = {
  --           padding = {
  --             left = 1,
  --             right = 1,
  --           },
  --         },
  --         ---@type table<string, string|function|table<string, string|function>>
  --         keymaps = {
  --           ['<LeftMouse>'] = function()
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             local mouse = vim.fn.getmousepos()
  --             if mouse.winid ~= menu.win then
  --               local prev_menu = utils.menu.get({ win = mouse.winid })
  --               if prev_menu and prev_menu.sub_menu then
  --                 prev_menu.sub_menu:close()
  --               else
  --                 utils.menu.exec('close')
  --                 utils.bar.exec('update_current_context_hl')
  --               end
  --               if vim.api.nvim_win_is_valid(mouse.winid) then
  --                 vim.api.nvim_set_current_win(mouse.winid)
  --               end
  --               return
  --             end
  --             menu:click_at({ mouse.line, mouse.column - 1 }, nil, 1, 'l')
  --           end,
  --           ['<CR>'] = function()
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             local cursor = vim.api.nvim_win_get_cursor(menu.win)
  --             local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
  --             if component then
  --               menu:click_on(component, nil, 1, 'l')
  --             end
  --           end,
  --           ['<MouseMove>'] = function()
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             local mouse = vim.fn.getmousepos()
  --             -- If mouse is not in the menu window or on the border, end preview
  --             -- and clear hover highlights
  --             if mouse.winid ~= menu.win or mouse.line <= 0 or mouse.column <= 0 then
  --               -- Find the root menu
  --               while menu and menu.prev_menu do
  --                 menu = menu.prev_menu
  --               end
  --               if menu then
  --                 menu:finish_preview(true)
  --                 menu:update_hover_hl()
  --               end
  --               return
  --             end
  --             if M.opts.menu.preview then
  --               menu:preview_symbol_at({ mouse.line, mouse.column - 1 }, true)
  --             end
  --             menu:update_hover_hl({ mouse.line, mouse.column - 1 })
  --           end,
  --           i = function()
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             menu:fuzzy_find_open()
  --           end,
  --         },
  --         ---@alias dropbar_menu_win_config_opts_t any|fun(menu: dropbar_menu_t):any
  --         ---@type table<string, dropbar_menu_win_config_opts_t>
  --         ---@see vim.api.nvim_open_win
  --         win_configs = {
  --           border = 'none',
  --           style = 'minimal',
  --           row = function(menu)
  --             return menu.prev_menu
  --                 and menu.prev_menu.clicked_at
  --                 and menu.prev_menu.clicked_at[1] - vim.fn.line('w0')
  --                 or 0
  --           end,
  --           ---@param menu dropbar_menu_t
  --           col = function(menu)
  --             if menu.prev_menu then
  --               return menu.prev_menu._win_configs.width
  --                   + (menu.prev_menu.scrollbar and 1 or 0)
  --             end
  --             local mouse = vim.fn.getmousepos()
  --             local bar = utils.bar.get({ win = menu.prev_win })
  --             if not bar then
  --               return mouse.wincol
  --             end
  --             local _, range = bar:get_component_at(math.max(0, mouse.wincol - 1))
  --             return range and range.start or mouse.wincol
  --           end,
  --           relative = 'win',
  --           win = function(menu)
  --             return menu.prev_menu and menu.prev_menu.win
  --                 or vim.fn.getmousepos().winid
  --           end,
  --           height = function(menu)
  --             return math.max(
  --               1,
  --               math.min(
  --                 #menu.entries,
  --                 vim.go.pumheight ~= 0 and vim.go.pumheight
  --                 or math.ceil(vim.go.lines / 4)
  --               )
  --             )
  --           end,
  --           width = function(menu)
  --             local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
  --             if vim.tbl_isempty(menu.entries) then
  --               return min_width
  --             end
  --             return math.max(
  --               min_width,
  --               math.max(unpack(vim.tbl_map(function(entry)
  --                 return entry:displaywidth()
  --               end, menu.entries)))
  --             )
  --           end,
  --         },
  --       },
  --       fzf = {
  --         ---@type table<string, string | fun()>
  --         keymaps = {
  --           ['<LeftMouse>'] = function()
  --             ---@type dropbar_menu_t
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             local mouse = vim.fn.getmousepos()
  --             if not mouse then
  --               return
  --             end
  --             if mouse.winid ~= menu.win then
  --               local default_func = M.opts.menu.keymaps['<LeftMouse>']
  --               if type(default_func) == 'function' then
  --                 default_func()
  --               end
  --               menu:fuzzy_find_close(false)
  --               return
  --             elseif mouse.winrow > vim.api.nvim_buf_line_count(menu.buf) then
  --               return
  --             end
  --             vim.api.nvim_win_set_cursor(menu.win, { mouse.line, mouse.column - 1 })
  --             menu:fuzzy_find_click_on_entry(function(entry)
  --               return entry:get_component_at(mouse.column - 1, true)
  --             end)
  --           end,
  --           ['<MouseMove>'] = function()
  --             ---@type dropbar_menu_t
  --             local menu = utils.menu.get_current()
  --             if not menu then
  --               return
  --             end
  --             local mouse = vim.fn.getmousepos()
  --             if not mouse then
  --               return
  --             end
  --             -- If mouse is not in the menu window or on the border, end preview
  --             -- and clear hover highlights
  --             if
  --                 mouse.winid ~= menu.win
  --                 or mouse.line <= 0
  --                 or mouse.column <= 0
  --                 or mouse.winrow > #menu.entries
  --             then
  --               -- Find the root menu
  --               while menu and menu.prev_menu do
  --                 menu = menu.prev_menu
  --               end
  --               if menu then
  --                 menu:finish_preview(true)
  --                 menu:update_hover_hl()
  --               end
  --               return
  --             end
  --             if M.opts.menu.preview then
  --               menu:preview_symbol_at({ mouse.line, mouse.column - 1 }, true)
  --             end
  --             menu:update_hover_hl({ mouse.line, mouse.column - 1 })
  --           end,
  --           ['<Esc>'] = function()
  --             require('dropbar.api').fuzzy_find_toggle()
  --           end,
  --           ['<Enter>'] = function()
  --             require('dropbar.api').fuzzy_find_click()
  --           end,
  --           ['<S-Enter>'] = function()
  --             require('dropbar.api').fuzzy_find_click(-1)
  --           end,
  --           ['<Up>'] = function()
  --             require('dropbar.api').fuzzy_find_navigate('up')
  --           end,
  --           ['<Down>'] = function()
  --             require('dropbar.api').fuzzy_find_navigate('down')
  --           end,
  --           ['<C-k>'] = function()
  --             require('dropbar.api').fuzzy_find_navigate('up')
  --           end,
  --           ['<C-j>'] = function()
  --             require('dropbar.api').fuzzy_find_navigate('down')
  --           end,
  --         },
  --         -- Options passed to `:h nvim_open_win`. The fuzzy finder will use its
  --         -- parent window's config by default, but options set here will override those.
  --         win_configs = {},
  --         ---@type string
  --         prompt = '%#htmlTag# ',
  --         ---@type string
  --         char_pattern = '[%w%p]',
  --         ---@type boolean
  --         retain_inner_spaces = true,
  --         ---@type boolean
  --         -- When opening an entry with a submenu via the fuzzy finder,
  --         -- open the submenu in fuzzy finder mode.
  --         fuzzy_find_on_click = true
  --       },
  --       sources = {
  --         path = {
  --           ---@type string|fun(buf: integer, win: integer): string
  --           relative_to = function(_, win)
  --             -- Workaround for Vim:E5002: Cannot find window number
  --             local ok, cwd = pcall(vim.fn.getcwd, win)
  --             return ok and cwd or vim.fn.getcwd()
  --           end,
  --           ---Can be used to filter out files or directories
  --           ---based on their name
  --           ---@type fun(name: string): boolean
  --           filter = function(_)
  --             return true
  --           end,
  --           ---Last symbol from path source when current buf is modified
  --           ---@param sym dropbar_symbol_t
  --           ---@return dropbar_symbol_t
  --           modified = function(sym)
  --             return sym
  --           end,
  --         },
  --         treesitter = {
  --           -- Lua pattern used to extract a short name from the node text
  --           name_pattern = '[#~%*%w%._%->!@:]+%s*'
  --               .. string.rep('[#~%*%w%._%->!@:]*', 3, '%s*'),
  --           -- The order matters! The first match is used as the type
  --           -- of the treesitter symbol and used to show the icon
  --           -- Types listed below must have corresponding icons
  --           -- in the `icons.kinds.symbols` table for the icon to be shown
  --           valid_types = {
  --             'array',
  --             'boolean',
  --             'break_statement',
  --             'call',
  --             'case_statement',
  --             'class',
  --             'constant',
  --             'constructor',
  --             'continue_statement',
  --             'delete',
  --             'do_statement',
  --             'enum',
  --             'enum_member',
  --             'event',
  --             'for_statement',
  --             'function',
  --             'h1_marker',
  --             'h2_marker',
  --             'h3_marker',
  --             'h4_marker',
  --             'h5_marker',
  --             'h6_marker',
  --             'if_statement',
  --             'interface',
  --             'keyword',
  --             'list',
  --             'macro',
  --             'method',
  --             'module',
  --             'namespace',
  --             'null',
  --             'number',
  --             'operator',
  --             'package',
  --             'pair',
  --             'property',
  --             'reference',
  --             'repeat',
  --             'scope',
  --             'specifier',
  --             'string',
  --             'struct',
  --             'switch_statement',
  --             'type',
  --             'type_parameter',
  --             'unit',
  --             'value',
  --             'variable',
  --             'while_statement',
  --             'declaration',
  --             'field',
  --             'identifier',
  --             'object',
  --             'statement',
  --             'text',
  --           },
  --         },
  --         lsp = {
  --           request = {
  --             -- Times to retry a request before giving up
  --             ttl_init = 60,
  --             interval = 1000, -- in ms
  --           },
  --         },
  --         markdown = {
  --           parse = {
  --             -- Number of lines to update when cursor moves out of the parsed range
  --             look_ahead = 200,
  --           },
  --         },
  --         terminal = {
  --           ---@type string|fun(buf: integer): string
  --           icon = function(buf)
  --             local icon = M.opts.icons.kinds.symbols.Terminal
  --             if M.opts.icons.kinds.use_devicons then
  --               icon = require('nvim-web-devicons').get_icon_by_filetype(
  --                 vim.bo[buf].filetype
  --               ) or icon
  --             end
  --             return icon
  --           end,
  --           ---@type string|fun(buf: integer): string
  --           name = vim.api.nvim_buf_get_name,
  --           ---@type boolean
  --           ---Show the current terminal buffer in the menu
  --           show_current = true,
  --         }
  --       },
  --     }
  --     require('dropbar').setup(opts)
  --   end
  -- }
}
