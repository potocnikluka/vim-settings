--=============================================================================
-------------------------------------------------------------------------------
--                                                         TELESCOPE-UNDO-NVIM
--=============================================================================
-- https://github.com/debugloop/telescope-undo.nvim
--_____________________________________________________________________________

--[[
View and search your undo tree

Keymaps:
  - "<leader>tu" - Open the undo tree prompt
--]]

local M = {
  "debugloop/telescope-undo.nvim",
}

function M.init()
  vim.keymap.set("n", "<leader>tu", function()
    require("telescope").extensions.undo.undo()
  end)
end

function M.config()
  local telescope = require "telescope"
  local themes = require "telescope.themes"
  telescope.setup {
    extensions = {
      undo = themes.get_ivy(),
    },
  }

  telescope.load_extension "undo"
end

return M
