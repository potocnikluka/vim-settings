"==============================================================================
"------------------------------------------------------------------------------
"                                                                        FORMAT
"==============================================================================
" File formating.
"
" To change default settings or change a formater for a filetype add variable
" to 'init.vim' under 'VARIABLES'.
"
" All remappings are in 'remappings.vim'.
" _____________________________________________________________________________

"------------------------------------------------------------- default settings
if !exists('g:format_save')
	let g:format_save = 1
endif
if !exists('g:format_ignore')
	let g:format_ignore = 'markdown,netrw,text'
endif
"______________________________________________________________ format the file

function! Format()
	if !Check_format_options() | return | endif
	if g:format_save | silent! w | endif
	silent! normal mz
	let formater = ''
	if !exists('g:' . &filetype . '_formater')
		echo "No formater specified, using default indenting."
		silent! normal gg=Gg'z
		if g:format_save | silent! w | endif
		return
	else
		execute('let formater = g:' . &filetype . '_formater')
	endif
	let name = split(formater, ' ')[0]
	if !executable(name)
		echo "Cannot execute " . name . ", using default indenting."
		silent! normal gg=Gg'z
		if g:format_save | silent! w | endif
		return
	endif
	let formater = join(split(formater, ' '), '\ ')
	try
		execute('set equalprg=' . formater)
		silent normal G=gg
		set equalprg=""
		if stridx(getline('.'), 'error') != -1 ||
					\stridx(getline('.'), '/bin/bash') != -1
			let er = getline('.')
			silent! undo
			echo er
		else
			echo "Formated with " . name
		endif
	catch er
		try
			echo er
			set equalprg=""
			silent normal G=gg
			echo 'Could not format with ' . name . ', using default indenting.'
		catch error
			echo error
		endtry
	endtry
	silent! normal g'z
	if g:format_save | silent! w | endif
endfunction

"------------------------------------------------------- check if valid options
function! Check_format_options()
	if matchstr(g:format_ignore, &filetype) != ''
		echo 'Cannot format this filetype'
		return 0
	endif
	if g:format_save != 1 && g:format_ignore != 0
		echo 'Invalid g:format_save value'
		return 0
	endif
	return 1
endfunction
