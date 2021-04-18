"==============================================================================
"------------------------------------------------------------------------------
"                                                                         NETRW
"==============================================================================
" Config for vim's default file browser netrw.
"
" To change default settings add variables to 'init.vim' under 'VARIABLES'.
"
" All remappings are in 'remappings.vim'.
" _____________________________________________________________________________

"------------------------------------------------------------- default settings
if !exists('g:netrw_open_on_start')
	let g:netrw_open_on_start=0
	"1 -> auto open netrw when oppening a directory
endif
if !exists('g:netrw_disable')
	let g:netrw_disable=0
	"1 -> disable netrw completely
endif

"-------------------------------------------------------------- netrw variables
let g:netrw_banner = 0 "Disable directory preview press 'I' to show it
let g:netrw_liststyle = 3 "Tree appearance
let g:netrw_browse_split = 4 "Open file on the right of the file browser
let g:netrw_winsize = 15 "Size of netrw window
let g:netrw_altv=1 "Open splits to the right
"___________________________________________________ TOGGLE NETRW with Ctrl - n

let g:netrw_buf = 0

function! ToggleNetrw()
	if g:netrw_disable
		return
	endif
	if bufwinnr(g:netrw_buf) != -1
		silent! execute("bwipeout " . g:netrw_buf)
		return
	endif
	silent Lexplore
	silent vertical resize 31
	let g:netrw_buf = bufnr("")
endfunction

function! On_netrw_edit()
	if bufwinnr(g:netrw_buf) != -1
		silent! execute("bwipeout " . g:netrw_buf)
	endif
endfunction
let g:Netrw_funcref= function("On_netrw_edit")

if g:netrw_disable
	let g:loaded_netrw=1
	let g:loaded_netrwPlugin=1
endif

augroup Netrw
	autocmd!
	"-------------------------------------- Open netrw when opening directories
	if g:netrw_open_on_start && !g:netrw_disable
		autocmd VimEnter * if expand("%") == "" |
					\ silent Lexplore | wincmd p | q |
					\ let g:netrw_buf = bufnr("") |
					\ endif
	endif
augroup END
