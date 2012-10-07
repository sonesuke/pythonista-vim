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
command! -nargs=0 RemoveUnwantedSpaces exec("py remove_unwanted_spaces()")
" }}}1

" let &cpo = s:cpo_save

:python <<EOF
import vim
import re

def remove_unwanted_spaces():
    remove_unwanted_spaces_in_a_line()
    remove_last_blank_lines()
    append_two_blank_lines_before_class()


def remove_unwanted_spaces_in_a_line():
    cb = vim.current.buffer
    for i in range(len(cb)):
	cb[i] = re.sub('\s*$', '', cb[i])


def remove_last_blank_lines():
    cb = vim.current.buffer
    for i in range(len(cb) - 1, 0, -1):
	if cb[i] != "":
	    break
	del cb[i]


def append_two_blank_lines_before_class():
    cb = vim.current.buffer
    blank_lines = 0
    i = 0
    while i < len(cb):
	if re.search('class.+:', cb[i]) and blank_lines != 2:
	    diff = 2 - blank_lines
	    if diff > 0:
		cb.append([""] * diff, i)
		i += diff
	    else:
		for n in range(-diff):
		    del cb[i+diff]
		i += diff
	if cb[i] == "":
	    blank_lines += 1
	else:
	    blank_lines = 0
	i += 1

EOF
" vim:set ft=vim ts=8 sw=4 sts=4:
