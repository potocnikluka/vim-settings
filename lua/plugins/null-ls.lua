--=============================================================================
-------------------------------------------------------------------------------
--                                                                 NULL-LS.NVIM
--[[===========================================================================
https://github.com/jose-elias-alvarez/null-ls.nvim

Injects lsp diagnostics, code actions, formatting,...

Keymaps:
  - <leader>f  - Format current file and save (or selection if in visual mode)

Commands:
  - :NullLsInfo - Show information about the current null-ls session
  - :NullLsLog  - Open the log file
-----------------------------------------------------------------------------]]
local M = {
  "jose-elias-alvarez/null-ls.nvim",
  cmd = { "NullLsInfo", "NullLsLog" },
}

local format
function M.format_selection()
  return format(true)
end

function M.format()
  return format(false)
end

M.keys = {
  { "<leader>f", M.format, mode = "n" },
  { "<leader>f", M.format_selection, mode = "v" },
}

function M.config()
  local null_ls = require "null-ls"

  null_ls.setup()
end

---@param selection boolean: Format only current selection
function format(selection)
  local ok, e = pcall(function()
    local opts = {
      timeout_ms = 5000,
      async = true,
    }
    if selection then
      opts.range = {
        ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
        ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
      }
    end
    vim.lsp.buf.format(opts)
  end)
  if not ok and type(e) == "string" then
    vim.notify(vim.inspect(e), "warn", { title = "NullLs - Format" })
  end
end

---@param opts string|table
function M.register_formatter(opts)
  M.register_builtin_source("formatting", opts)
end

---@param opts string|table
function M.register_linter(opts)
  M.register_builtin_source("diagnostics", opts)
end

local expand_opts
---@param type string
---@param opts string|table
function M.register_builtin_source(type, opts)
  local ok, e = pcall(function()
    opts = expand_opts(opts)
    local null_ls = require "null-ls"
    local s = null_ls.builtins[type][opts.source]
    if not s then
      vim.notify(
        "No such builtin source: " .. vim.inspect(opts.source),
        "warn",
        {
          title = "NullLs",
        }
      )
      return
    end
    if opts.config and next(opts.config) then
      s = s.with(opts.config)
    end
    null_ls.register {
      filetypes = { opts.filetype },
      sources = { s },
    }
  end)
  if not ok then
    vim.notify("Error registering builtin source: " .. vim.inspect(e), "warn", {
      title = "NullLs",
    })
  end
end

expand_opts = function(opts)
  local o = {}
  if type(opts) == "string" then
    o.source = opts
    o.filetype = vim.bo.filetype
  else
    opts = opts or {}

    o.source = opts[1]
    if type(o.source) ~= "string" then
      o.source = opts.source
    end

    opts.source = nil
    opts[1] = nil
    opts.filetype = nil

    o.filetype = opts.filetype or vim.bo.filetype
    o.config = opts
  end
  return o
end

return M
