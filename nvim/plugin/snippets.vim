"=============================================================================
"------------------------------------------------------------------------------
"                                                                      SNIPPETS
"==============================================================================
" Show all snippets in a popup, create new snippets,...
"
" To change default settings add variables to 'init.vim' under 'VARIABLES'.
"
" All remappings are in 'remappings.vim'.
" _____________________________________________________________________________

"------------------------------------------------------------- default settings
if !exists('g:load_snippets')
	let g:load_snippets=0
	"1 -> load snippets on start, 0 -> don't load
	"If snippets are not loaded they can be pasted only from 'call Snippets()'
	"command and not with a key binding.
	"They can be manually loaded with 'call Snippets('load')'
endif

"------------------------------------------------------------- snippets command
let g:snip_info = {
			\'win': 0,
			\'border_win': 0,
			\'buf': 0,
			\'border_buf': 0,
			\}
let g:snips = {}

function! Snippets(args)
	let wipe = 0
	if win_gotoid(g:snip_info['win'])
		if count(['save', 'save!', 'load'], a:args) == 0
			call Close_snip_window()
			let wipe = 1
		endif
	endif
	if a:args == ''
		if wipe | return | endif
		call Show_snippets()
	elseif a:args == 'load'
		call Load_snippets()
	elseif a:args == 'save' || a:args == 'save!'
		call Save_snippet(a:args)
	else
		call Add_snippets(a:args)
	endif
endfunction

"------------------------------------------------------ Show availible snippets
function! Show_snippets()
	call Create_popup('SNIPPETS', g:snip_info, 'On_snip_popup')
	set bufhidden=wipe
	set noreadonly
	let text = globpath(',', stdpath('config') . '/snippets/*')
	for i in split(text, '\n')
		let i = split(i, '/')[-1]
		if Valid_snippet(i)
			silent! execute("normal o►  " . i)
		endif
	endfor
	normal gg0
	set readonly
endfunction

"------------------------------------------------------------ add a new snippet
function! Add_snippets(name)
	call Create_popup('CREATE SNIPPET', g:snip_info, 'On_snip_popup')
	set noreadonly
	set bufhidden=wipe
	if matchstr(a:name, '\.') != ''
		execute("set filetype=" . Get_filetype(split(a:name, '\.')[1]))
	endif
	let text = [
				\"Name: " . a:name ,
				\"Key binding:",
				\"Move cursor:",
				\"Code:",
				\''
				\]
	call nvim_put(text, 'l', v:true, v:true)
endfunction

"----------------------------------------------------------------- save snippet
function! Save_snippet(arg)
	try
		if bufnr("") != g:snip_info['buf']
			return
		endif
		if !isdirectory(stdpath('config') . '/snippets')
			echo "Please create " . stdpath('config') . "/snippets directory"
			return
		elseif getline(2) == 'Name:' || getline(1) == 'Name: '
			echo "Please provide a file name"
			return 
		elseif getline(3) == 'Key binding:' || getline(3) == 'Key binding: '
			echo "Please add a key binding"
			return
		elseif line('$') < 6 || line('$') < 7 && getline(6) == ''
			echo "Cannot save an empty snippet."
			return
		endif
		let name = split(getline(2), 'Name: ')
		if len(name) < 1
			let name = split(getline(2), 'Name:')
		endif
		let name = name[0]
		if filereadable(stdpath('config') . '/snippets/'.name) && a:arg == 'save'
			echo "File already exists, add ! to override."
			return
		endif
		set noreadonly
		normal ggdd
		execute("w! " . stdpath('config') . "/snippets/" . name)
		call Close_snip_window()
	catch error
		echo error
	endtry
endfunction

"------------------------------- load the snippets for pasting with key binding
function! Load_snippets()
	let text = globpath(',', stdpath('config') . '/snippets/*')
	for i in split(text, '\n')
		let i = split(i, '/')[-1]
		if Valid_snippet(i)
			let x = g:snips[i][0]
			if matchstr(x, "Key binding: ") != ''
				let x = split(x, "Key binding: ")[0]
			else
				let x = split(x, "Key binding:")[0]
			endif
			let cmd = "nnoremap  " . x . " :call Paste_snippet('".i."')<CR>"
			silent! execute(cmd)
		endif
	endfor
endfunction

"------------------------------------------------------------ paste the snippet
function! Paste_snippet(snippet)
	set noreadonly
	let data = g:snips[a:snippet]
	let i = 3
	let move = 1
	if matchstr(data[1], 'Move cursor') == ''
		let i = 2
		let move = 0
	endif
	let data = data[i:]
	silent! execute("bwipeout " . g:snip_info['buf'])
	silent! execute("bwipeout " . g:snip_info['border_buf'])
	if !&modifiable || !&write
		echo "Could not paste"
	endif
	call nvim_put(data, 'c', v:true, v:false)
	if move
		let x = 'Move cursor:'
		if matchstr(g:snips[a:snippet][1], 'Move cursor: ') != ''
			let x = 'Move cursor: '
		endif
		let m = split(g:snips[a:snippet][1], x)
		if len(m) == 0
			return
		endif
		let cmd = 'normal ' . split(g:snips[a:snippet][1], x)[0]
		execute(cmd)
	endif
endfunction

"--------------------------------------------------------- do on pressing enter
function! On_snip_select()
	set noreadonly
	try
		let snippet = getline('.')
		let x = split(snippet, ' ')
		if len(x) > 1 && x[0] == '▼'
			s/▼/►/I
			silent! normal mzj3ddg'z0
		elseif len(x) > 1 && x[0] == '►' 
			s/►/▼/I
			let snippet = split(snippet, ' ')
			if len(snippet) < 2
				set readonly
				return
			endif
			let snippet = snippet[2]
			if !has_key(g:snips, snippet) && !Valid_snippet(snippet)
				set readonly
				return
			endif
			let content = g:snips[snippet]
			execute("normal o    ".content[0])
			if matchstr(content[1], 'Move cursor:') == ''
				execute("normal o    Move cursor:")
			else
				execute("normal o    ".content[1])
			endif
			execute("normal o    PASTE")
			silent normal 3k0
		elseif snippet == '    PASTE'
			let snippet = split(getline(line('.') - 3), ' ')[2]
			call Paste_snippet(snippet)
			return
		endif
	catch err
		echo err
		return
	endtry
	if &filetype == 'snippets'
		set readonly
	endif
endfunction

"------------------------------------------- check if string is a valid snippet
function! Valid_snippet(snip)
	try
		let content = readfile(stdpath('config') . '/snippets/' . a:snip)
	catch
		return 0
	endtry
	if len(content) < 3 | return 0 | endif
	if matchstr(content[0], 'Key binding:') != '' &&
				\(matchstr(content[2], 'Code:') != '' || 
				\matchstr(content[1], 'Code:') != '')
		let g:snips[a:snip] = content
		return 1
	endif
	return 0
endfunction

"------------------------------------------------------------- create new popup
function! Create_popup(name, info, popup_fun)
	set noreadonly
	let height = float2nr((&lines - 2) * 0.7)
	let row = float2nr((&lines - height) / 2)
	let width = float2nr(&columns * 0.4)
	let col = float2nr((&columns - width) / 2)
	" Border Window
	let border_opts = {
				\ 'relative': 'editor',
				\ 'row': row - 1,
				\ 'col': col - 2,
				\ 'width': width + 4,
				\ 'height': height + 2,
				\ 'style': 'minimal'
				\ }
	" Terminal Window
	let opts = {
				\ 'relative': 'editor',
				\ 'row': row,
				\ 'col': col,
				\ 'width': width,
				\ 'height': height,
				\ 'style': 'minimal'
				\ }
	let half1 = float2nr((width - len(a:name)) / 2)
	let half2 = (width - len(a:name)) - half1
	let top = "╭" . repeat("─", half1) . " ".a:name." " . repeat("─", half2) . "╮"
	let mid = "│" . repeat(" ", width + 2) . "│"
	let bot = "╰" . repeat("─", width + 2) . "╯"
	let lines = [top] + repeat([mid], height) + [bot]
	let a:info['border_buf'] = nvim_create_buf(v:false, v:true)
	call nvim_buf_set_lines(a:info['border_buf'], 0, -1, v:true, lines)
	let a:info['border_win'] = nvim_open_win(
				\a:info['border_buf'], v:true, border_opts)
	let a:info['buf'] = nvim_create_buf(v:false, v:true)
	let a:info['win'] = nvim_open_win(a:info['buf'], v:true, opts)
	" Styling
	highlight FloatWinBorder guifg=#87bb7c
	call setwinvar(a:info['border_win'], '&winhl', 'Normal:FloatWinBorder')
	call setwinvar(a:info['win'], '&winhl', 'Normal:Normal')
	nnoremap <buffer> <silent><Esc> <cmd>call Close_snip_window()<CR>
	if a:popup_fun != ''
		execute("call " . a:popup_fun . "()")
	endif
endfunction

function! Close_snip_window()
	silent! execute("bwipeout " . g:snip_info['buf'])
	silent! execute("bwipeout " . g:snip_info['border_buf'])
endfunction

"-------------------------------------------------- execute when creating popup
function! On_snip_popup()
	set readonly
	setlocal filetype=snippets
	setlocal noautoindent
	setlocal nosmartindent
	setlocal cursorline
	syntax match Info "^► .*"
	syntax match Info "^▼.*"
	highlight def link Info Constant
	syntax match Paste "PASTE"
	highlight def link Paste Function
	map <buffer> <silent><CR> <cmd>call On_snip_select()<CR>
endfunction

"------------------------------------------------------------- get the filetype
function! Get_filetype(fl)
	if a:fl == 'py'
		return 'python'
	elseif a:fl == 'js'
		return 'javascript'
	elseif a:fl == 'ts'
		return 'typescript'
	endif
	return a:fl
endfunction

"--------------------------------------------- auto load snippets if option = 1
if g:load_snippets
	autocmd VimEnter * call Snippets('load')
endif
