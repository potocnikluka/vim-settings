"==============================================================================
"------------------------------------------------------------------------------
"                                                                      TERMINAL
"==============================================================================
" General terminal settings and toggling terminal.
"
" To change default settings, add variables to 'init.vim' under 'VARIABLES'.
"
" All remappings are in 'remappings.vim'.
" _____________________________________________________________________________
"
"------------------------------------------------------------- Default settings
if !exists('g:terminal_toggle_type')
	let g:terminal_toggle_type=0
	"0 -> vertical, 1 -> horizontal
endif
if !exists('g:terminal_toggle_size')
	let g:terminal_toggle_size=50
	"from 1 to 200
endif
"______________________________________________________________ TOGGLE TERMINAL

let g:term_buf = 0
let g:term_win = 0
function! Term_toggle()
	if g:terminal_toggle_type != 1 && g:terminal_toggle_type != 0
		echo "Invalid g:terminal_toggle_type value"
		return
	endif
	let size = str2nr(g:terminal_toggle_size)
	if size < 1 || size > 200
		echo "Invalid g:terminal_toggle_size value"
		return 0
	endif
	if win_gotoid(g:term_win)
		hide
	else
		if g:terminal_toggle_type == 1
			new
			execute "resize ".g:terminal_toggle_size
		else
			vertical new
			execute "vertical resize ".g:terminal_toggle_size
		endif
		try
			exec "buffer " . g:term_buf
		catch
			call termopen($SHELL, {"detach": 0})
		endtry
		startinsert!
		let g:term_buf = bufnr("")
		let g:term_win = win_getid()
	endif
endfunction
