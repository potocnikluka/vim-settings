let g:nvimpath = stdpath('config') "path to nvim directory

"==============================================================================
"------------------------------------------------------------------------------
"                                                                       PLUGINS
"==============================================================================

call plug#begin(''.g:nvimpath.'/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
call plug#end()


"_________________________________________________________ AUTO INSTALL PLUGINS

autocmd VimEnter *
			\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\|   PlugInstall --sync | q
			\| endif


"==============================================================================
"------------------------------------------------------------------------------
"                                                    FILETYPE SPECIFIC SETTINGS
"==============================================================================
let g:filetypes = {}

"------------------------------------------------------------- DEFAULT SETTINGS
" First check for .vim.json in the path, if there are no settings 
" specified for the filetype, use defaults

let g:filetypes['python'] = {
			\'interpreter': ['python3', '%:p'],
			\'formater': ['autopep8', ' -']
			\}
let g:filetypes['c'] = {
			\'compiler': 
			\['gcc', '%:p', '-o', '%:p:r', '-std=c99 -Wall -pedantic'],
			\'execute': ['%:p:r']
			\}
let g:filetypes['cs'] = {
			\'compiler': 
			\['csc', '%:p'],
			\'execute': ['mono', '%:p:r.exe']
			\}
let g:filetypes['java'] = {
			\'compiler': 
			\['javac', '%:p'],
			\'execute': ['java', '%:p']
			\}
let g:filetypes['typescript'] = {
			\'compiler': ['tsc', '%:p'],
			\'execute': ['node', '%:p:r.js'],
			\'formater': ['prettier', ' --user-tabs stdin-filepath %']
			\}
let g:filetypes['javascript'] = {
			\'interpreter': ['node', '%:p'],
			\'formater': ['prettier', ' --use-tabs --stdin-filepath %']
			\}


"----------------------------------------------------- READ INFO FROM .vim.json

let g:filetypes2 = g:filetypes
function! FindFile(lookFor)
	let pathMaker = '%:p'
	while len(expand(pathMaker.':h')) > 1
		let pathMaker = pathMaker.':h'
		if filereadable((expand(pathMaker)).'/'.a:lookFor)
			return expand(pathMaker).'/'.a:lookFor
		endif
	endwhile
	return ''
endfunction

function! ReadJson()
	let l:jsonFile = FindFile('.vim.json')
	if l:jsonFile == ''
		return
	endif
	try
		let l:jsonData = json_decode(readfile(expand(l:jsonFile)))
		for [key, value] in items(l:jsonData)
			let g:filetypes[key] = value
		endfor
	catch error
		echo error
		return
	endtry
endfunction

autocmd VimEnter * call ReadJson()
