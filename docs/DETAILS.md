## DETAILS

### basic-behaviour.vim
This file includes most of the basic settings and some remappings.

### lsp.vim
Configurations for language servers and some general lsp and autocompletion settings. 
See [config](CONFIG.md) for more on adding language servers.

### netrw.vim
Netrw is configured to mimick the nerdtree plugin. While from time to time you might run into a bug, 
it still allows you to get a good visual representation of the project. 
It provides all the required functionality without a plugin.
* It can be toggled with `<C-n>`.
* On oppening a directory it should be automatically toggled on.
* It should automatically close if it is the last oppened buffer.
* You can create a directory with `d`, create a file with `%`, move or rename a file with `R`, delete with `D`,...

### colors.vim
These settings use Gruvbox color scheme (https://github.com/morhetz/gruvbox), and syntax colors, 
which provide decent colors for most of the languages, are set up to match the theme.

### statusline.vim
Statusline shows the current mode, full file path, filetype, current column, current line, total lines, current buffer number and git branch.
* When there are multiple tabs, tabline appears.
* Both status and tab line show '+' if the file has been edited.

### terminal.vim
This file includes settings for toggling terminal and running programs.
* Terminal can be toggled with `F4` (toggling it off only hides the buffer, so the terminal keeps the same instance).
* Command `:R` asynchronously runs the program and shows the output in the side split (it requires setting up [compilers/interpreters](docs/CONFIG.md)).
	- The errorlist (side split) can be toggled with `<S-e>`.
	- You can add arguments to the R command 
	(if filetype requires compiling and running, it will use arguments starting with '-' when compiling and others when running the program).

### formating.vim
Files can be formated with `<space-f>`.
* If formater is not installed, executable or specified for the filetype, default indenting will be used (requires settings up [formaters](docs/CONFIG.md)).

### parantheses.vim
Closing parantheses are autocompleted.
* You can press the sign twice to avoid autocompletion.

### snippets.vim
These settings allow simple snippets manipulation.
* Type `:Snippets` to see all the availible snippets.
* See [config](CONFIG.md) for more on creating snippets.
