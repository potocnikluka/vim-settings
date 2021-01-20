"==============================================================================
"------------------------------------------------------------------------------
"                                                                     FORMATING
"==============================================================================


let g:formaters = {
			\'javascript': 'prettier',
			\'typescript': 'prettier',
			\'python': 'autopep8' 
			\}
function! Formate()
	silent w	
	"set mark z
	normal mz
	if has_key(g:formaters, &filetype)
		try 
			if &filetype =~ 'typescript\|javascript'
				execute 'setlocal equalprg='.g:formaters[&filetype].'
							\\ --use-tabs\ --stdin-filepath\ %'
			else
				execute 'setlocal equalprg='.g:formaters[&filetype].'\ -'
			endif
			let l:lines = line('$')
			silent execute "normal gg=G"
			execute 'setlocal equalprg=""'
		finally "undo and use the default indenting if error occurs
			"if the first line includes substring command not found
			"the formater probably isn't installed
			if stridx(getline('.'),
						\ ''.g:formaters[&filetype].': command not found')
						\ != -1
				silent undo
				execute "normal gg=G"
				echo 'Could not format with '.g:formaters[&filetype].'
							\, using default indenting.'
				"if the first line or last line includes substring error
				"send errors to cmd instead of formating
			elseif stridx(getline('.'), 
						\ 'error')
						\ != -1
				let l:err = getline('.')
				silent undo
				echo l:err
			elseif stridx(getline(l:lines + 1),
						\ 'error')
						\ != -1
				let l:err = getline(l:lines + 1)
				silent undo
				echo l:err
			else
				echo 'formated with '.g:formaters[&filetype].''
			endif
		endtry
	else
		execute "normal gg=G"
	endif
	"return to mark and don't remember jump
	normal g'z
	silent w
endfunction
nnoremap <silent><leader>f :call Formate()<CR>
