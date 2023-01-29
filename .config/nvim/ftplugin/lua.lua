--=============================================================================
-------------------------------------------------------------------------------
--                                                                          LUA
--[[===========================================================================
Loaded when a lua file is opened
-----------------------------------------------------------------------------]]

if vim.g.ftplugin_lua_loaded then
  return
end
vim.g.ftplugin_lua_loaded = true

local lspconfig = require "plugins.lspconfig"
local null_ls = require "plugins.null-ls"

null_ls.register_formatter "stylua"

lspconfig.start_language_server("sumneko_lua", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.tbl_extend("force", vim.split(package.path, ":"), {
          "lua/?.lua",
          "lua/?/init.lua",
        }),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})