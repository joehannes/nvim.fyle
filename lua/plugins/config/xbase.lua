local M = {}

function M.setup()
  require 'xbase'.setup( -- NOTE: Defaults
    {
      --- Log level. Set it to ERROR to ignore everything
      log_level = vim.log.levels.DEBUG,
      --- Options to be passed to lspconfig.nvim's sourcekit setup function.
      --- Usually empty map is sufficient, However, it is strongly recommended to use on_attach key to setup custom mapppings
      sourcekit = {}, --- Set it to nil to skip lspconfig's sourcekit setup
      --- Statusline provider configurations
      statusline = {
        watching = { icon = "", color = "#1abc9c" },
        device_running = { icon = "", color = "#4a6edb" },
        success = { icon = "", color = "#1abc9c" },
        failure = { icon = "", color = "#db4b4b" },
      },
      --- Simulators to only include.
      --- run `xcrun simctl list` to get a full list of available simulator
      --- If the list is empty then all simulator available  will be included
      simctl = {
        iOS = {
          -- "iPhone 13 Pro", --- only use this devices
        },
        watchOS = {}, -- all available devices
        tvOS = {},    -- all available devices
      },
      --- Log buffer configurations
      log_buffer = {
        --- Whether toggling the buffer should auto focus to it?
        focus = true,
        --- Split Log buffer height
        height = 20,
        --- Vsplit Log buffer width
        width = 75,
        --- Default log buffer direction: { "horizontal", "vertical" }
        default_direction = "horizontal",
      },
      --- Mappings
      mappings = {
        --- Whether xbase mapping should be disabled.
        enable = true,
        --- Open build picker. showing targets and configuration.
        build_picker = "<leader>x<cr>b", --- set to 0 to disable
        --- Open run picker. showing targets, devices and configuration
        run_picker = "<leader>x<cr>r",   --- set to 0 to disable
        --- Open watch picker. showing run or build, targets, devices and configuration
        watch_picker = "<leader>x<cr>w", --- set to 0 to disable
        --- A list of all the previous pickers
        all_picker = "<leader>x<cr>!",   --- set to 0 to disable
        --- horizontal toggle log buffer
        toggle_split_log_buffer = "<leader>tlxs",
        --- vertical toggle log buffer
        toggle_vsplit_log_buffer = "<leader>tlxv",
      },
    }) -- see default configuration bellow
end

return M
