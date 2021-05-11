"==============================================================================
"------------------------------------------------------------------------------
"                                                                    REMAPPINGS
"==============================================================================
" All of the remappings and user defined commands.
"______________________________________________________________________________

"<leader> --> space
let mapleader=" "

"-------------------------------------------------------------------------- LSP
"jump to definition
noremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
"show info of word under cursor in popup
noremap <silent>K <cmd>lua vim.lsp.buf.hover()<CR>

"------------------------------------------------------------------ RUN PROGRAM
" Run program with :R, autocomplete filenames for arguments
command! -complete=file -nargs=* R call Run_program(<q-args>)
" toggle errorlist with leader + e
map <silent><leader>e <cmd>call Toggle_errorlist()<CR>

"--------------------------------------------------------------------- TERMINAL
" toggle terminal with F4
nnoremap <silent><F4> <cmd>call Term_toggle()<CR>
tnoremap <silent><F4> <C-\><C-n> <cmd>call Term_toggle()<CR>
" leave terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>

"----------------------------------------------------------------------- FORMAT
" format the file with leader f
nnoremap <silent><leader>f <cmd>call Format()<CR>

"--------------------------------------------------------------------- SNIPPETS
"Open snippets window with leader + q, load snippets with leader + l
"Create new snippet with :Sn(ippets) name.filetype
command! -nargs=* Snippets call Snippets(<q-args>)
nnoremap <leader>q <cmd>Snippets<CR>
nnoremap <leader>l <cmd>Snippets load<CR>

"------------------------------------------------------------------------ NETRW
"toggle netrw explorer in side split with Ctrl + n
map <silent><C-n> <cmd>call ToggleNetrw()<CR>

"-------------------------------------------------------------- SCROLLING POPUP
"down with tab
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
"up with shift + tab
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"select with enter
inoremap <expr><CR> pumvisible() ? "<C-y>" : "\<CR>"

"--------------------------------------------------------------------- QUICKFIX
"next err
nnoremap <leader>k <cmd>cn<CR>
"prev err
nnoremap <leader>j <cmd>cp<CR>

"----------------------------------------------------------------------- RANDOM
"leave insert mode with jj
inoremap <silent>jj <Esc>
"jump to previous file with tab, forward with shift + tab
nnoremap <S-TAB> <C-O>
"resize window with + and -
nnoremap + <cmd>vertical resize +5<CR>
nnoremap - <cmd>vertical resize -5<CR>
"switch window focus with leader + w
nnoremap <leader>w <cmd>wincmd w<CR>
"open new vertical window with leader + v
nnoremap <leader>v <cmd>vertical new<CR>
"Yank selected text to system clipboard with Ctrl + C
function! X()
	yank
	let @+=@"
	echo 'Yanked to system clipboard'
endfunction
vnoremap <C-c> <cmd>call X()<CR>
"misstyping uppercase Q or W instead of lowercase and getting error is
" frustrating
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
