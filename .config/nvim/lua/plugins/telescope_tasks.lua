--=============================================================================
-------------------------------------------------------------------------------
--                                                         TELESCOPE-TASKS-NVIM
--=============================================================================
-- https://github.com/lpoto/telescope-tasks.nvim
--_____________________________________________________________________________

--[[
Synchronous tasks from a telescope prompt.

Keymaps:
  - "<leader>a" - Open the tasks prompt
  - "<leader>e" - Toggle latest output
--]]

local M = {
  "lpoto/telescope-tasks.nvim",
}

function M.init()
  vim.keymap.set("n", "<leader>a", function()
    require("telescope").extensions.tasks.tasks()
  end)
  vim.keymap.set("n", "<leader>e", function()
    require("telescope").extensions.tasks.actions.toggle_last_output()
  end)
end

function M.config()
  local telescope = require "telescope"
  telescope.setup {
    extensions = {
      tasks = {
        theme = "ivy",
        output = {
          style = "float",
          layout = "center",
        },
        enable_build_commands = false,
      },
    },
  }

  telescope.load_extension "tasks"

  telescope.extensions.tasks.generators.default.all()
end

return M