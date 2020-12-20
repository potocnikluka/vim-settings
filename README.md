# Neovim settings
My preffered linux neovim settings.

Neovim (https://github.com/neovim/neovim) is an ambitious vim-fork, trying to modernize vim. 
It provides better plugin API than vim, better codebase and a great community. 
Lately it has also been providing great features sooner than vim.
    
## Prerequisites
   - neovim v0.5
   - git

## Configuration
   - Replace local nvim folder (~/.config/nvim) with the folder from these settings
   - in nvim run command ```:PlugInstall``` and restart the editor
   - see Details for more on LSP and Snippets configuration

## Details

### Pluggins:
Thise settings include a few lightweight plugins.

* Implement LSP:
   - nvim-lspconfig (https://github.com/neovim/nvim-lspconfig) - lightweight collection of common configurations for LSP.
   - Completion-nvim (https://github.com/nvim-lua/completion-nvim) - auto completion framework for a better completion experience with LSP.
* Other:
   - indentLine to make it prettier (https://github.com/Yggdroot/indentLine)
   - vim-fugitive (https://github.com/tpope/vim-fugitive) - git plugin for vim

### LSP
Nvim supports the Language Server Protocol (LSP), which means it acts as
a client to LSP servers and includes a Lua framework `vim.lsp` for building
enhanced LSP tools.

* Adding language servers to LSP (look to init.vim under PLUGGINS/LSP for examples):
   - Add the following code to init.vim:
   ```lua require'lspconfig'.<server-name>.setup{<settings>}```
   - To allow autocompletion from server add the following setting to the code above:
   ```on_attach=require'completion'.on_attach```
   - Run :LspInstall <server-name> in editor (some servers need to be installed manually)

See nvim-lspconfig repository for more lsp configuration information.


### Snippets
You can easily create your own snippets with these settings:
   - Create snippet-name.filetype file in nvim/snippets/
   - Add your snippet code to that file
   - In init.vim add code following the examples under SNIPPETS:
    ```nnoremap <your-key-mapping>:-1read ~/.config/nvim/additions/snippets/snippet-name.filetype```
   - You can add keys to remapping to move cursor to desired location when placing the snippet
Set up compilers and compiling paths to suit your needs in init.vim under TERMINAL AND RUNNING THE PROGRAM.

### OTHER
* Colortheme: Gruvbox(https://github.com/morhetz/gruvbox)
* Added syntax highlight for basic groups

* Statusline showing current mode, full file path, filetype, encoding, operating system, current column, current line, total lines, git branch and buffer number.
* Tabline appears if there are at least two tabs.
* Both statusline and tabline show + if the file has been edited.

* Toggle terminal with F4.
* In editor, type :R to asynchronously run the program in the side split. Toggle the terminal running the program with Shift + e, if there is no nothing running Shift - e will run the program.

* Autocompletion for parentheses, press the sign twice to insert a single sign.

* Netrw set up to perform similar to nerdtree. ( Create a new file with % and directory with d, rename or move with R and delete with D)



