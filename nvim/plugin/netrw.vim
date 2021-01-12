"==============================================================================
"------------------------------------------------------------------------------
"                                                                         NETRW
"==============================================================================


let g:netrw_banner = 0 "Disable directory preview press "I" to show it
let g:netrw_liststyle = 3 "Tree appearance
let g:netrw_browse_split = 4 "Open file on the right of the file browser
let g:netrw_winsize = 15 "Size of netrw window
let g:NetrwIsOpen = 0 "netrw oppened or not
let g:netrw_altv=1 "Open splits to the right
let g:netrw_silent=1


"___________________________________________________ TOGGLE NETRW with Ctrl - n

function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i
			endif
			let i -= 1
		endwhile
		let g:NetrwIsOpen=0
	else
		silent Lexplore
		silent vertical resize 31
		let g:NetrwIsOpen=1
	endif
endfunction
map <silent><C-n> :call ToggleNetrw()<CR>

augroup Netrw
	autocmd!
	"-------------------------------------- Open netrw when opening directories
	autocmd VimEnter * if expand("%") == "" |
				\ silent Explore|
				\ let g:NetrwIsOpen=1|
				\ endif
	"---------------------------------------------- Toggle off on opening files
	autocmd BufWinEnter * if &filetype !~ 'netrw' &&
				\ g:NetrwIsOpen |
				\ call ToggleNetrw() |
				\ endif
	"----------------------------------------------- Close if last oppened file
	autocmd bufenter * if (winnr("$") == 1 && &filetype =~ 'netrw') | q | endif
augroup END
