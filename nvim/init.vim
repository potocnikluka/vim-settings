"'init.vim' contains plugins, basic settings and all important variables, so
"they don't mess with project specific settings read from additional config
"file in a project's directory.
"Other configurations are gathered in 'nvim/plugin'
"------------------------------------------------------------------------------

let g:config_path=stdpath('config') "path to neovim's config directory
let g:OS=substitute(system('uname'), '\n', '', '') "Operating system
"==============================================================================
"------------------------------------------------------------------------------
"                                                                       PLUGINS
"==============================================================================

call plug#begin(g:config_path.'/plugged')
"----------------------------------------- collection of configurations for LSP 
Plug 'neovim/nvim-lspconfig'
"----------------------------------------------------- autocompletion framework
Plug 'nvim-lua/completion-nvim'
call plug#end()

"==============================================================================
"------------------------------------------------------------------------------
"                                                               BASIC BEHAVIOUR
"==============================================================================

syntax on
filetype plugin indent on
set exrc "use project's local nvim config file if exists
set noerrorbells "Disable error sounds
set updatetime=50 "Shorten updatetime from 4s to 50ms
set path=.,,** "search down into subfodlers
set wildmenu "display matching files with tab completion
set wildignore+=**/node_modules/** "ignore searching node modules
set wildignore+=**/.git/** "ignore searching git folders
set timeoutlen=500 "Shorten timeout for key combinations
"set clipboard=unnamedplus "always copy to system clipboard when yanking

"--------------------------------------------------------------------------- UI

set background=dark "dark background
colorscheme gruvbox "gruvbox colortheme
set number "Show numbers on the side
set relativenumber "Show numbers relative to your position
set nowrap "Do not wrap multiple lines in one line
"set cmdheight=2 "Enable more space for displaying messages
set scrolloff=8 "minimum number of lines above or bellow cursor
set smartcase "override ignorecase option
set nohlsearch "Stop highlighting for hlsearch option
set splitbelow "open new buffer below in normal split
set splitright "open new buffer on the right in vertical split
set incsearch "Show current match while typing search pattern
set guicursor= "disable cursor styling
set showmatch "Briefly show the matching bracket
set notitle  "dont show title on top
set signcolumn=number "join error and sign column
set noshowmode "don't show mode in cmd
set cursorline
"set cursorcolumn
"set colorcolumn=80
set list "show indentline
"use │ for indentline
set listchars=tab:\│\ 
"enable 256 colors if terminal does not enable it by default
set t_Co=256
set termguicolors

"------------------------------------------------------------------ SAVE / UNDO
set noswapfile "Load buffers without creating swap files
set nobackup "Do not automatically save
set undofile "Allow undo after reoppening the file
execute 'set undodir='.g:config_path.'/undo'

"-------------------------------------------------------------------- INDENTING
set tabstop=4 softtabstop=4 "set tab width
set shiftwidth=4
set smartindent "smart indent the new line

"_________________________________________________________________ AUTOCOMPLETE
set shortmess+=c "Don't give ins-completion-menu messages
set completeopt=menuone "Show completion popup with only one match
set completeopt+=noinsert,noselect "Dont atuo insert words

"==============================================================================
"------------------------------------------------------------------------------
"                                                                     VARIABLES
"==============================================================================

"-------------------------------------------------------------------- FILETYPES
"compiler format -> '<compiler-name> <path> <additional-options>'
"interpreter format -> '<interpreter-name> <path> <additional-options>'
"formater format -> '<formater-name> <path> <additional-options>'
"execute -> optional command used after compiling 
"(ex. run the prog. after successful compiling)

"** paths should be given unexpanded see `:h expand`
"extension can be changed for unexpanded paths (%:p:r.new_extension)
"example: %:p -> ~/test.vim, %:p:r.txt -> ~/test.txt


let g:python_interpreter="python3 %:p"
let g:python_formater="autopep8 %"

let g:c_compiler="gcc %:p -o %:p:r -std=c99 -Wall -pedantic"
let g:c_execute="%:p:r"

let g:cpp_compiler="g++ %:p -o %:p:r -std=c++98 -Wall -pedantic"
let g:cpp_execute="%:p:r"

let g:cs_compiler="csc %:p"
let g:cs_execute="mono %:p:r.exe"

let g:typescript_compiler="tsc %:p"
let g:typescript_execute="node %:p:r.js"
let g:typescript_formater="prettier --use-tabs %"

let g:javascript_interpreter="node %:p"
let g:javascript_formater="prettier --use-tabs %"

"------------------------------------------------------------------------ OTHER
let g:errorlist_size = 80
