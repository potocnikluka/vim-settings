"==============================================================================
"------------------------------------------------------------------------------
"                                                                     FORMATING
"==============================================================================

set tabstop=4 softtabstop=4 "set tab width
set shiftwidth=4
set smartindent "smart indent the new line


"save and format
function! Format()
	if &filetype =~ 'markdown\|text\|netrw\|nerdtree' 
		return
	endif
	silent w	
	"set mark z
	silent normal mz
	if has_key(g:filetypes, &filetype) &&
				\has_key(g:filetypes[&filetype], 'formater')
		"check if formater can be executed
		let l:formater = g:filetypes[&filetype]['formater']
		if !executable(l:formater[0])
			silent execute "normal gg=Gg'zw"
			echo 'Could not execute '.l:formater[0].'
						\, using default indenting.'
			return 
		endif
		try 
			for i in range(1, len(l:formater) - 1)
				let l:x = join(split(l:formater[i], '\\\ '), ' ')
				let l:x = join(split(l:x, '\ '), '\ ')
				let l:formater[i] = '\ '.l:x
			endfor
			execute 'setlocal equalprg='.l:formater[0].'
						\'.l:formater[1].''
			silent execute "normal gg=G"
			execute 'setlocal equalprg=""'
			if stridx(getline('.'), 
						\ 'error')
						\ != -1
				let l:err = getline('.')
				silent undo
				echo l:err
			else
				echo 'formated with '.l:formater[0].''
			endif
		catch
			try 
				silent undo
				execute "normal gg=G"
				echo 'Could not format with '.l:formater[0].'
							\, using default indenting.'
				return 
			catch
				silent undo
				echo 'Could not format.'
				return
			endtry
		endtry
	else
		execute "normal gg=G"
	endif
	"return to mark and don't remember jump
	silent normal g'z
	silent w
endfunction

nnoremap <silent><leader>f :call Format()<CR>
