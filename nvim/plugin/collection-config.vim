"==============================================================================
"------------------------------------------------------------------------------
"                                                                COLLECTION-VIM
"==============================================================================
"
"-------------------------------------------------------------------- FILETYPES
"compiler format -> '<compiler-name> <path> <additional-options>'
"interpreter format -> '<interpreter-name> <path> <additional-options>'
"formater format -> '<formater-name> <path> <additional-options>'
"execute -> optional command used after compiling 
"(ex. run the prog. after successful compiling)

"** paths should be given unexpanded see `:h expand`
"extension can be changed for unexpanded paths (%:p:r.new_extension)
"example: %:p -> ~/test.vim, %:p:r.txt -> ~/test.txt


let g:collection_python_interpreter="python3 %:p"
let g:collection_python_formater="autopep8 %"

let g:collection_c_compiler="gcc %:p -o %:p:r -std=c99 -Wall -pedantic"
let g:collection_c_execute="%:p:r"

let g:collection_cpp_compiler="g++ %:p -o %:p:r -std=c++98 -Wall -pedantic"
let g:collection_cpp_execute="%:p:r"

let g:collection_cs_compiler="csc %:p"
let g:collection_cs_execute="mono %:p:r.exe"

let g:collection_typescript_compiler="tsc %:p"
let g:collection_typescript_execute="node %:p:r.js"
let g:collection_typescript_formater="prettier --use-tabs %"

let g:collection_javascript_interpreter="node %:p"
let g:collection_javascript_formater="prettier --use-tabs %"
