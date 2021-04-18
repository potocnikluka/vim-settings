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
noremap <silent>gd :lua vim.lsp.buf.definition()<CR>
"show info of word under cursor in popup
noremap <silent>K :lua vim.lsp.buf.hover()<CR>

"------------------------------------------------------------------ RUN PROGRAM
command! -nargs=* R call Run_program(<q-args>)
map <silent><leader>e :call Toggle_errorlist()<CR>

"--------------------------------------------------------------------- TERMINAL
nnoremap <silent><F4> :call Term_toggle()<CR>
tnoremap <silent><F4> <C-\><C-n> :call Term_toggle()<CR>
tnoremap <Esc> <C-\><C-n>

"----------------------------------------------------------------------- FORMAT
nnoremap <silent><leader>f :call Format()<CR>

"--------------------------------------------------------------------- SNIPPETS
command! -nargs=* Snippets call Snippets(<q-args>)
nnoremap <leader>q :Snippets<CR>
nnoremap <leader>l :Snippets load<CR>

"------------------------------------------------------------------------ NETRW
map <silent><C-n> :call ToggleNetrw()<CR>

"-------------------------------------------------------------- SCROLLING POPUP
"down with tab
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
"up with shift tab
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"select with enter
inoremap <expr><CR> pumvisible() ? "<C-y>" : "\<CR>"

"--------------------------------------------------------------------- QUICKFIX
"next err
nnoremap <leader>k :cn<CR>
"prev err
nnoremap <leader>j :cp<CR>

"----------------------------------------------------------------------- RANDOM
command! Q :q
command! W :w
command! Wq :wq
inoremap <silent>jj <Esc>
nnoremap <S-TAB> <C-O>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>v :vertical new<CR>

"==============================================================================
"------------------------------------------------------------------------------
"                                                    Parentheses autocompletion
"==============================================================================

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
