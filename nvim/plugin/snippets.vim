"==============================================================================
"------------------------------------------------------------------------------
"                                                                      SNIPPETS
"==============================================================================


"----------------------------------------- match java class name with file name
command! CTF let g:text=expand('%:t') |
			\normal cw<C-r>=g:text<CR><Esc>diwhx


"________________________________________________________________ java snippets

let g:snippets = [ 
			\[',jm', 'main.java', 'o'],
			\[',jis', 'intToString.java', '6wli'],
			\[',jpl', 'println.java', '5wli'],
			\[',jc', 'class.java', '2w:CTF<CR>o'],
			\[',jcm', 'classMain.java', '2w:CTF<CR>jo'],
			\[',jcms', 'classMainScanner.java', '2j2w:CTF<CR>2jo'],
			\]
for snippet in g:snippets  
	execute 'nnoremap '.snippet[0].'
				\ :-1read '.g:nvimpath.'/snippets/'.snippet[1].'<CR>
				\'.snippet[2].' <esc>:echo "snippet: '.snippet[1].'"<CR>'
endfor
"----------------------------------- show all availible snippets with :Snippets
command! Snippets for snippet in g:snippets |
			\ echo ''.snippet[0].'  -->  '.snippet[1].'' |
			\ endfor
