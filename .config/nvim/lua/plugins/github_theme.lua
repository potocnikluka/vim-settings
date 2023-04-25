--=============================================================================
-------------------------------------------------------------------------------
--                                                            GITHUB-NVIM-THEME
--=============================================================================
-- https://github.com/projekt0n/github-nvim-theme
--_____________________________________________________________________________

return {
  "projekt0n/github-nvim-theme",
  version = "v0.0.7",
  lazy = false,
  config = function()
    local colorscheme = require "github-theme"

    colorscheme.setup {
      theme_style = "dark",
      transparent = true,
      function_style = "italic",
      overrides = function()
        return {
          Identifier = { link = "Normal" },
          LineNr = { link = "WinSeparator" },
          ["@field"] = { link = "Special" },
          Type = { fg = "#E6BE8A" },
          ["@type"] = { link = "Type" },
          StatusLine = { link = "WinSeparator" },
          TabLine = { link = "WinSeparator" },
          TabLineFill = { link = "WinSeparator" },
        }
      end,
    }

    vim.cmd.colorscheme "github_dark"
  end,
}