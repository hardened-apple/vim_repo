" add a simple toggle for test scripts
nnoremap <buffer> [om :set makeprg=javac\ %<CR>
nnoremap <buffer> ]om :set makeprg=make<CR>

runtime! ftplugin/c_languages.vim

" Overwrite the foldmethod from c_languages.vim
set foldmethod=syntax
