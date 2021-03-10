## CONFIG

Different interpreters, compilers and formaters can be set for any filetype. 
On startup, vim will search for `.vim.json` file, which can include settings, 
that override default settings in `init.vim`.

### Default settings
In `init.vim` add your default configurations:

`let g:filetypes['<filetype>'] = {<options>}`

Possible options:
* formater:
	`'formater': ['<formater>', '<path,.. options>']`
* Interpreter:
	`'interpreter': ['<interpreter>, '<path>', <options>']'`
* Compiler (interpreter overrides compiler):
	`'compiler': ['<compiler>' '<path>', <options>]`
* Execute (adding execute option will run the program after successful compiling):
	`'Execute': ['<path-to-executable,..>']`

*unexpanded path should be given ('%:p' - full path, '%:p:h' - without tail, '%:p:r' - without extension...) or as a setting.*

Examples:
	```
	let g:filetypes['python'] = {
		\'interpreter': ['python3', '%:p'],
		\'formater': ['autopep8', ' -'],
		\}
	
	let g:filetypes['c'] = {
		\'compiler': ['gcc', '%:p', '-o', '%:p:r', '-Wall -pedantic'],
		\'execute': ['%:p:r']
		\}
	let g:filetypes['java']: {
		\"compiler": ["javac", "%:p"],
		\"execute": ["java", "%:p"]
	\}
	```

### .vim.json
`.vim.json` file can be created in the root of the project, overriding default settings
(settings for filetypes not specified in the json file will keep the default configurations).

Example .vim.json:
```
{
	let g:filetypes['typescript'] = {
		'compiler': ['tsc', '--project tsconfig.json'],
		'formater': ['prettier', ' --use tabs --stdin-filepath %']
	}
}
```

### LSP
Most supported servers can be enabled by adding the following code to `nvim/lsp.vim`:
```
	lua require'lspconfig'.<language-server>.setup{}
```

You can enable autocompletion by adding a parameter to the server's setup:
```
	lua require'lspconfig'.<language-server>.setup{on_attach=require'completion'.on_attach}
```
*You need to manually install the language servers on to your computer.*
*See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md for more details.*

### Snippets
* Create `snippet-name.filetype` file in `nvim/snippets/`.
* Add your snippet code to that file.
* In `nvim/plugin/snippets.vim` implement the `g:snippets` dictionary with you snippet:

	```let g:snippets = [['key-mapping', 'snippet-file-name', 'move-cursor-after']]```

**See already written examples in the file.**
