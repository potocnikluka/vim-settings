"==============================================================================
"------------------------------------------------------------------------------
"                                                                   RUN PROGRAM
"==============================================================================
" Asynchronous program running.
"
" To change default settings or change compiler, execute or interpreter for a
" filetype, add variables to 'init.vim' under 'VARIABLES'.
"
" All remappings are in 'remappings.vim'.
" _____________________________________________________________________________

"------------------------------------------------------------- default settings
if !exists('g:errorlist_type')
	let g:errorlist_type=0
	"0 -> vertical, 1 -> horizontal
endif
if !exists('g:errorlist_size')
	let g:errorlist_size=50
	"from 1 to 200
endif
if !exists('g:errorlist_save')
	let g:errorlist_save=1
	"1 -> save when running program, 0 -> don't save
endif
if !exists('g:run_program_ignore')
	let g:run_program_ignore='netrw,markdown,text,vim'
	"List of comma separated files to forbid running program
endif

let g:prog_buf = 0
let g:prog_win = 0
"______________________________________________________________ Run the program
"
function! Run_program(args)
	if !Check_run_options() | return | endif
	execute("silent! bwipeout! " . g:prog_buf)
	let win_nr = winnr()
	let interpreter = ''
	let compiler = ''
	let execute = ''
	"Check if compiler, interpreter, execute are set
	if exists('g:' . &filetype . "_interpreter")
		execute("let interpreter = g:" . &filetype . "_interpreter")
		if !Check_if_executable(interpreter) | return | endif
	elseif exists('g:' . &filetype . "_compiler")
		execute("let compiler = g:" . &filetype . "_compiler")
		if !Check_if_executable(compiler) | return | endif
	endif
	if exists('g:' . &filetype . "_execute")
		execute("let execute = g:" . &filetype . "_execute")
		if !Check_if_executable(execute) | return | endif
	endif
	"Build the run command
	let cmd = Build_command(interpreter, compiler, execute, a:args)
	if cmd == ''
		echo "Could not run the program"
		return
	endif
	if g:errorlist_save | silent! w | endif
	let cur_win = winnr()
	let x = Create_window()
	if !x 
		echo "Could not create window."
	endif
	call termopen(''.cmd.'', {'detach': 0})
	set winfixwidth
	normal G
	set filetype=errorlist
	let g:prog_buf = bufnr("")
	let g:prog_win = win_getid()
	execute(win_nr . " wincmd p")
	"echo command text
	let txt = ''
	for i in split(cmd, "")
		if len(i) > 20 && matchstr(i, "/") != ""
			let i = '.../' . split(i, "/")[-1]
		endif
		if txt == '' && i != ''
			let txt = i
		elseif i != ''
			let txt = txt . " " . i
		endif
	endfor
	echo txt
endfunction

"------------------------------Check if compiler, interpreter,... is executable
function! Check_if_executable(args)
	if a:args[0] =~ '%' 
		return 1 
	endif
	let name = split(a:args, " ")[0]
	if !executable(name)
		echo 'Cannot execute '.name
		return 0
	endif
	return 1
endfunction

"------------------------------Build the command from compiler, interpreter,...
function! Build_command(interpreter, compiler, execute, args)
	let cmd = ''
	try
		if a:interpreter != ''
			let cmd = Add_to_command(cmd, a:interpreter)
		elseif a:compiler != ''
			let cmd = Add_to_command(cmd, a:compiler)
		endif
		"add arguments with '-'
		let cmd = Add_arguments(cmd, a:args, '-')
		if a:execute != ''
			let cmd = cmd . '  && ' . Add_to_command('', a:execute)
		endif
		"add other arguments
		let cmd = Add_arguments(cmd, a:args, '')
	catch
		return ''
	endtry
		return cmd
endfunction

"---------------------------------------------------------Add  parts to command
function! Add_to_command(cmd, args)
	let cmd = a:cmd
	try
		for i in split(a:args, " ")
			if i[0] =~ '%'
				if matchstr(i, '/.') != ''
					let s = ''	
					let x = split(i, '.')
					for j in x
						if j[0] =~ '%'
							let j = expand(j)
						endif
						let s = s . j
					endfor
					let cmd = cmd . " " . s
				else
					let i = expand(i)
				endif
			endif
			let cmd = cmd . " " . i
		endfor
	catch
		return ''
	endtry
	return cmd
endfunction

"---------------------------------------------------- Add  arguments to command
function! Add_arguments(cmd, args, type)
	let cmd = a:cmd
	for i in split(a:args, " ")
		if a:type == '-' 
			if i[0] == '-'
				let cmd = cmd . " " . i
			endif
		else
			if i[0] != '-'
				let cmd = cmd . " " . i
			endif
		endif
	endfor
	return cmd
endfunction

"--------------------------------------------------------------Toggle errorlist
function! Toggle_errorlist()
	if !Check_run_options() | return | endif
	let cur_win = winnr()
	if win_gotoid(g:prog_win)
		hide
		execute(cur_win . " wincmd p")
		return
	endif
	try
		let x = Create_window()
		if !x 
			echo "Could not create new window."
			return
		endif
		execute("buffer " . g:prog_buf)
		let g:prog_buf = bufnr("")
		let g:prog_win = win_getid()
		setlocal winfixwidth
		normal G
		execute(cur_win . " wincmd p")
	catch
		q!
		echo "Nothing is running"
	endtry
endfunction

"------------------------------------------------------- Check if valid options
function! Check_run_options()
	if matchstr(g:run_program_ignore, &filetype) != ''
		echo "Cannot run the command for this filetype"
		return 0
	endif
	if g:errorlist_type != 0 && g:errorlist_type != 1
		echo "Invalid g:errorlist_type value"
		return 0
	endif
	let size = str2nr(g:errorlist_size)
	if size < 1 || size > 200
		echo "Invalid g:errorlist_size value"
		return 0
	endif
	return 1
endfunction

"---------------------------------------------------------------- Create window
function! Create_window()
	try
		let type = 'vertical new errorlist | vertical resize '
		if g:errorlist_type == 1
			let type = 'new errorlist | resize '
		endif
		execute(type . g:errorlist_size)
	catch
		return 0
	endtry
	return 1
endfunction
