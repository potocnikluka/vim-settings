"==============================================================================
"------------------------------------------------------------------------------
"                                       READ FILETYPE SETTINGS FROM CONFIG FILE 
"==============================================================================
" On open look for an additional config file that allows project specific
" configurations.
"
" To change default settings add variables to 'init.vim' under 'VARIABLES'.
"_____________________________________________________________________________

"------------------------------------------------------------- default settings
if !exists('g:additional_config')
	let g:additional_config=1
	"1 -> look for additional config file, 0-> don't
endif
if !exists('g:additional_config_file')
	let g:additional_config_file='.config.vim'
	"default name of a file for project-specific settings
endif

"------------------------------------------------------------- default settings
function! Find_file(lookFor)
	let path_maker = '%:p:h'
	try
		while len(expand(path_maker)) > len(expand('~'))
			if filereadable((expand(path_maker)).'/'.a:lookFor)
				return expand(path_maker).'/'.a:lookFor
			endif
			let path_maker = path_maker.':h'
		endwhile
		return ''
	catch error
		echo error
		return ''
	endtry
endfunction

function! Get_settings(additional_config_file)
	try
		let config_file = Find_file(a:additional_config_file)
		if config_file == '' | return | endif
		execute('source '.config_file)
	catch error
		echo error
	endtry
endfunction

if g:additional_config
	call Get_settings(g:additional_config_file)
endif
