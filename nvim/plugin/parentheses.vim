"==============================================================================
"------------------------------------------------------------------------------
"                                                    Parentheses autocompletion
"==============================================================================
inoremap " ""<left>
inoremap "" "
inoremap ' ''<left>
inoremap '' '
inoremap ` ``<left>
inoremap `` `
inoremap ( ()<left>
inoremap (<cr> (<cr>)<Esc>O
inoremap (( (
inoremap () ()
inoremap [ []<left>
inoremap [<cr> [<cr>]<Esc>O
inoremap [[ [
inoremap [] []
inoremap { {}<left>
inoremap {<cr> {<cr>}<Esc>O
inoremap {{ {
inoremap {} {}
"--------------------------------- prevent highlight errors from delayed parens
let g:loaded_matchparen=1
