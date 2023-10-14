--=============================================================================
-------------------------------------------------------------------------------
--                                                                          PHP
--=============================================================================
if vim.g[vim.bo.filetype] or vim.api.nvim_set_var(vim.bo.filetype, true) then
  return
end

vim.lsp.attach({
  name = "phpactor",
  root_patterns = {
    ".git",
    "composer.json",
    "composer.lock",
    "vendor",
  },
})
vim.lsp.attach("phpcbf")