if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:prompt = 'vimshell: >'

" Get a process for this job
if !get(b:, 'vsh_job', 0)
  call ftplugin_helpers#vsh#StartSubprocess()
endif

" Don't insert newlines when writing a long command
setlocal formatoptions-=t
setlocal formatoptions-=c

" Abuse the comment system to give syntax highlighting (TBD in a syntax file)
" and automatic insertion of the prompt when hitting <Enter>
" NOTE -- order of the comment definition is important -- means lines with a
" '#' are recognised as a comment of the first kind rather than the second,
" which means that pressing <CR> in insert mode when on that line inserts the
" '#' on the next line (assuming the correct 'formatoptions' settings)
setlocal comments=b:vimshell\:\ >\ #,b:vimshell\:\ >
setlocal formatoptions+=r
setlocal formatoptions+=o

nnoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('n')<CR>
nnoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('n')<CR>
vnoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('v')<CR>
vnoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('v')<CR>
onoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('o')<CR>
onoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('o')<CR>
nnoremap <buffer> <silent> <CR>  :call ftplugin_helpers#vsh#ReplaceInput()<CR>
nnoremap <buffer> <silent> <localleader>n  :call ftplugin_helpers#vsh#NewPrompt()<CR>
nnoremap <buffer> <localleader>o  :<C-r>=ftplugin_helpers#vsh#CommandRange()<CR>

" This command is much more well-behaved in the memory-less version.
" We can't tell what output belongs to what command in the full-featured
" version, so output goes all over the place, but the commands do get run in
" the correct order, so it's still useful to a point.
command -buffer -range Rerun execute 'keeppatterns ' . <line1> . ',' . <line2> . 'global/' . b:prompt . '/call ftplugin_helpers#vsh#ReplaceInput()'
