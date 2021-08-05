"==============================================================================
"------------------------------------------------------------------------------
"                                                                    REMAPPINGS
"==============================================================================
" All of the remappings and user defined commands.
"______________________________________________________________________________
"<leader> --> space
let mapleader=" "
"leave insert with jj
inoremap <silent>jj <Esc>
"-------------------------------------------------------------------------- LSP
"jump to definition, show info of word under cursor
noremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
noremap <silent>K <cmd>lua vim.lsp.buf.hover()<CR>
"------------------------------------------------------------------ RUN PROGRAM
" Run program with :R, autocomplete filenames, toggle errorlist with leader-e
command! -complete=file -nargs=* R call Run_program(<q-args>)
map <silent><leader>e <cmd>call Toggle_errorlist()<CR>
"--------------------------------------------------------------------- TERMINAL
" toggle terminal with F4, leave terminal insert with escape
nnoremap <silent><F4> <cmd>call Term_toggle()<CR>
tnoremap <silent><F4> <C-\><C-n> <cmd>call Term_toggle()<CR>
tnoremap <Esc> <C-\><C-n>
"----------------------------------------------------------------------- FORMAT
" format the file with leader f
nnoremap <silent><leader>f <cmd>call Format()<CR>
"--------------------------------------------------------------------- SNIPPETS
"Open snippets window with leader + q, load snippets with leader + l
"Create new snippet with :Sn(ippets) name.filetype
command! -nargs=* Snippets call Snippets(<q-args>)
nnoremap <leader>q <cmd>call Snippets('')<CR>
nnoremap <leader>l <cmd>call Snippets('load')<CR>
"------------------------------------------------------------------------ NETRW
"toggle netrw explorer in side split with Ctrl + n
map <silent><C-n> <cmd>call ToggleNetrw()<CR>
"-------------------------------------------------------------- SCROLLING POPUP
"down with tab, up with shift-tab, select with enter
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? "<C-y>" : "\<CR>"
"-------------------------------------------------------------- WINDOW MANAGING
nnoremap + <cmd>vertical resize +5<CR>
nnoremap - <cmd>vertical resize -5<CR>
nnoremap <leader>w <cmd>wincmd w<CR>
nnoremap <leader>v <cmd>vertical new<CR>
"------------------------------------------------------------------ VISUAL MODE
"Y - select to the end of line, C-c - yanked text to clipboard
nnoremap Y y$
nnoremap <C-c> <cmd>let @+=@"<CR>
"---------------------------------------------------------------------- JUMPING
"center cursor when jumping, jump forward with tab, backward with shift-tab
"count j and k commands with a number larger than 5 as jumps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <leader>l <cmd>cnext<CR>zzzv
nnoremap <leader>j <cmd>cprev<CR>zzzv
nnoremap <S-TAB> <C-O>zzzv
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
"------------------------------------------------------------ UNDO BREAK POINTS
"start a new undo chain with punctuations
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
"------------------------------------------------------------------ MOVING TEXT
"switch lines in normal mode with leader-j or leader-k
"switch lines in insert mode with ctrl-j or ctrl-k
"switch selected text in visual mode with J or K
vnoremap K :m '>+1<CR>gv=gv
vnoremap J :m '<-2<CR>gv=gv
inoremap <C-k> <esc><cmd>m .-2<CR>==
inoremap <C-j> <esc><cmd>m .+1<CR>==
nnoremap <leader>k <cmd>m .-2<CR>==
nnoremap <leader>j <cmd>m .+1<CR>==
"---------------------------------------- SHORTER AND CASE INSENSITIVE COMMANDS
command! -bang -complete=file_in_path -nargs=* F find
command -bang Q q
command -bang W w
command -bang Wq wq
command -bang WQ wq
"==============================================================================
"------------------------------------------------------------------------------
"                                                    Parentheses autocompletion
"==============================================================================
"auto complete closing parantheses, typer enter to insert a new line 
" in between, double type the sing to only type it once
inoremap " ""<left>
inoremap "" "
inoremap ' ''<left>
inoremap '' '
inoremap ` ``<left>
inoremap `` `
inoremap ( ()<left>
inoremap (<cr> (<cr>)<Esc>O
inoremap (( (
inoremap () ()
inoremap [ []<left>
inoremap [<cr> [<cr>]<Esc>O
inoremap [[ [
inoremap [] []
inoremap { {}<left>
inoremap {<cr> {<cr>}<Esc>O
inoremap {{ {
inoremap {} {}
"--------------------------------- prevent highlight errors from delayed parens
let g:loaded_matchparen=1
