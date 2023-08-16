--=============================================================================
-------------------------------------------------------------------------------
--                                                                        OCAML
--=============================================================================
if vim.g[vim.bo.filetype] or vim.api.nvim_set_var(vim.bo.filetype, true) then
  return
end

vim.b.formatter = "ocamlformat"
vim.b.language_server = "ocamllsp"
