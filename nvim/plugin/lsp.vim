"==============================================================================
"------------------------------------------------------------------------------
"                                                                           LSP
"==============================================================================
" LSP servers configurations.
"
" Add a new server with:
"		'lsp.server-name.setup{}'
" To add autocompletion:
"		'lsp.server-name.setup{on_attach=completion.on_attach}'
"
" Some require additional configs.
"
" ** see configuration and installation guides on:
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md 
"______________________________________________________________________________

lua << EOF
local lsp = require'lspconfig'
local completion = require'completion'
---------------------------------------------------- typescript language server
lsp.tsserver.setup{on_attach=completion.on_attach}
-------------------------------------------------------- python language server
lsp.pylsp.setup{on_attach=completion.on_attach}
-------------------------------------------------------- c, c++ language server
lsp.clangd.setup{on_attach=completion.on_attach}
----------------------------------------------------------- vim language server
lsp.vimls.setup{on_attach=completion.on_attach}
EOF
