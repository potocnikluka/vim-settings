"==============================================================================
"------------------------------------------------------------------------------
"                                                                           LSP
"==============================================================================
" LSP servers configurations.
"
" Add a new server with:
"		'lsp.server-name.setup{}'
" Some require additional configs.
" To add autocompletion:
"		'lsp.server-name.setup{on_attach=completion.on_attach}'
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
lsp.pyls.setup{on_attach=completion.on_attach}

-------------------------------------------------------- c, c++ language server
lsp.clangd.setup{on_attach=completion.on_attach}

----------------------------------------------------------- vim language server
lsp.vimls.setup{on_attach=completion.on_attach}

----------------------------------------------------------- lua language server

local system_name = vim.g['config_path']
--- add your path to lua-language.server ---> mine is in HOME directory
local sumneko_root_path = vim.fn.expand('~/lua-language-server')
local sumneko_binary = sumneko_root_path.."/bin/"
..system_name.."/lua-language-server"
lsp.sumneko_lua.setup {
	on_attach=completion.on_attach;
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
EOF
