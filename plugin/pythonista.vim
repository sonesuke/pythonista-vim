"Exit quickly when:
"- this plugin was already loaded (or disabled)
"- when 'compatible' is set
if !has('python')
    finish
endif
if (exists("g:loaded_pythonista") && g:loaded_pythonista) || &cp
    finish
endif

let g:loaded_pythonista = 1

"let s:cpo_save = &cpo
"set cpo&vim


" Code {{{1
command! -nargs=0 RemoveLastBlankLines exec("py remove_last_blank_lines()")
" }}}1

" let &cpo = s:cpo_save

:python <<EOF
import vim

def remove_last_blank_lines():
    cb = vim.current.buffer
    for i in range(len(cb) - 1, 0, -1):
	if cb[i] != "":
	    break
	del cb[i]

EOF
" vim:set ft=vim ts=8 sw=4 sts=4:
