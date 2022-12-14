--=============================================================================
-------------------------------------------------------------------------------
--                                                               FORMATTER.NVIM
--=============================================================================
-- https://github.com/mhartington/formatter.nvim
--_____________________________________________________________________________

local formatter = require("util.packer_wrapper").get "formatter"

---Format on save, remove trailing whitespace when formatter is not set
formatter:config(function()
  require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.INFO,
    filetype = {
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace,
      },
    },
  }
end)

-- format with "<leader>f""
formatter:config(function()
  vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>FormatWriteLock<CR>", {
    noremap = true,
  })
end, "remappings")
