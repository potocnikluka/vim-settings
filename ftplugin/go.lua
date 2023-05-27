--=============================================================================
-------------------------------------------------------------------------------
--                                                                           GO
--[[===========================================================================
Loaded when a go file is opened
-----------------------------------------------------------------------------]]
Util.ftplugin {
  language_server = "gopls",
  formatter = "goimports",
  linter = "golangci_lint",
}
