# Neovim settings
Configurations for a comfortable neovim experience with only 2 lightweight 
plugins.

Neovim (https://github.com/neovim/neovim) is an ambitious vim-fork, that 
provides a better plugin API than vim, better codebase, a great community 
and some very useful features.

## Prerequisites
* neovim v0.5

## Configuration
* Replace local nvim folder with the folder from these settings.
	- Type `:echo stdpath('config')` in the editor to get the path to your 
	nvim directory (On linux usually `~/.config/nvim` and on windows usually 
	`~/AppData/Local/nvim`).

* Install plugins with `:PlugInstall`. If you get the 'command does not exist' 
error, try reinstalling [Vim-Plug](https://github.com/junegunn/vim-plug).

## Plugins

Nvim supports the Language Server Protocol (LSP), which means it acts as
a client to LSP servers and includes a Lua framework `vim.lsp` for building
enhanced LSP tools. These two plugins implement this feature.

* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - 
collection of common configurations for LSP.

* [Completion-nvim](https://github.com/nvim-lua/completion-nvim) - 
auto completion framework for a better completion experience with LSP.

## Features
* Ui settings (colorscheme [GruvBox](https://github.com/morhetz/gruvbox), 
syntax highlighting, statusline, tabline,...)
* Asynchronous program running,
* file formating,
* project specific `.config.vim` file, that allows changing settings for 
a project (ex. changing compilers, interpreters or formaters...),
* toggling terminal that keeps the same instance,
* configurations for vim's default file explorer netrw,
* snippet managing,
* useful remappings and parantheses autocompletion,
* LSP configurations (error linting, autocompletion,...).

### Details

`init.vim` includes basic settings, other configurations are split into
multiple files under `nvim/plugin` as that is the directory vim reads from
after reading `init.vim`.

Most of those files contain customizable options, but variables, changing 
those options, should be set in `init.vim`, so they don't interfere with 
additional settings set up in a project's `.config.vim` file.

Each file also contains additional info about the contents.

#### example .config.vim file
```
let g:typescript_compiler='tsc --project-tsconfig'
let g:typescript_formater='prettier %'
unlet g:typescript_execute

let g:netrw_open_on_start=1
```
