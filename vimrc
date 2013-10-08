"This is my vim Customisation file.

set nocompatible

" Pathogen plugin {{{
execute pathogen#infect()
call pathogen#helptags()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Manage spaces and tabs {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"stay indented when getting new line
set autoindent
set shiftwidth=4

"make a tab change to 4 spaces
set expandtab
set tabstop=4
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Errorbells {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Don't keep bugging me whenever I type something wrong
set noerrorbells
"set novisualbells
set t_vb=
set tm=500
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changing the look of the editor {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Make split windows open on right and below by default
set splitright
set splitbelow
"Add a foldcolumn
set foldcolumn=2
" Always show filename
set ls=2

"Highlights all occurances of the last search pattern
" but let Space in command mode turn off the highlighting
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
"I have no idea what the <Bar> part of this means

"add line numbers
set number

"get vim to automatically highlight based on syntax and file extension
syntax on
filetype on
" cursorline/column
set cursorcolumn
set cursorline
color techras
"if in the tty only have 8 colours - tell vim that
if &term == "linux" || &term == "screen"
    set t_Co=8
"if in xterm in X, have 256 colours, use them all
elseif &term == "xterm-256color" || &term == "xterm" || &term == "screen-256color"
    "This has to be set after the set syntax, as it is overwitten otherwise
    set t_Co=256
    "Make the cursor in command mode be a blinking block
    "and the cursor in insert mode be a solid underscore
    let &t_SI = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[1 q"
    "make the cursor change back when leave vim
    autocmd VimLeave * silent !echo -ne "\033]112\007"
endif


"set the characters seperating multiple vim windows to blank space
set fillchars=vert:\ 
"can use set fillchars+=diff:\\ to make deleted lines in diffmode
"have the '\' character along them instead of the '-' character

"Make the cursor always stay 3 lines inside the window when scrolling
set scrolloff=3
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use - commands and automation {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"General {{{

"Turn off the mouse
set mouse=""

set completeopt=menuone,menu,longest
inoremap <C-c> <ESC>
"give me two lines to write commands out
set cmdheight=2

" Backspaces
set backspace=indent,eol,start
" History
set history=50
set ruler

" Lower priority tab completion
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
"Separate windows when scrolling
set nocursorbind
set noscrollbind
"show commands as typing
"don't make automatic backups
set showcmd
set nobackup
"search current and above directory for tag file
set tags=./tags;$HOME
"turn the plugin lookup on
"turn automatic filetype indentation on
filetype plugin on
filetype indent on
"change how the command line autocomplete works
"set wildmode=<parameters>
set wildmenu
set smarttab
set shiftround
set autoread
" set shell=/usr/bin/zsh

" macro to put spaces around a character - python operators
let @s='?\S[=*+/-]\Sls  P:nohlsearch'

"indentation in visual
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$


" Allows /opening of buffers in the background/
set hidden
"set bufhidden=hide
"Format options:
set textwidth=79
"set auto comment and comment wrapping
"set textwrapping for normal lines
"add paragraph formatting options
"don't automatically break already long line
set formatoptions+=cro
set formatoptions+=t
set formatoptions+=q
set formatoptions+=l

"Make automatic open with folds all closed
set foldlevelstart=0

" Give me enough time to think aobut which command I want
set timeoutlen=1000

"Automatically save and load folds for text files (program files will
"have the syntax folding on).
"
au BufWinLeave ?*.txt mkview
au BufWinEnter ?*.txt silent loadview
"NOTE the regex matches filenames, the ? is there so it doesn't match empty
"filenames, else there would be an error when opening help

" Choose windows based on number
nnoremap <leader>1 :exe 1 . "wincmd w"<CR>
nnoremap <leader>2 :exe 2 . "wincmd w"<CR>
nnoremap <leader>3 :exe 3 . "wincmd w"<CR>
nnoremap <leader>4 :exe 4 . "wincmd w"<CR>
nnoremap <leader>5 :exe 5 . "wincmd w"<CR>
nnoremap <leader>6 :exe 6 . "wincmd w"<CR>
nnoremap <leader>7 :exe 7 . "wincmd w"<CR>
nnoremap <leader>8 :exe 8 . "wincmd w"<CR>
nnoremap <leader>9 :exe 9 . "wincmd w"<CR>
"}}}

"Omnicppcomplete options {{{
autocmd FileType c, cpp set omnifunc=syntaxcomplete#Complete "override builtin C
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 0 "prune out-of-scope variables
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop
let OmniCpp_ShowAccess          = 1 "show access
let OmniCpp_SelectFirstItem     = 2 "select first item
"}}}

"NERDcommenter options {{{
let g:NERDDefaultNesting=0
let g:NERDSpaceDelims=1
" }}}

" {{{ NERDTree plugin
nnoremap <leader>nl :NERDTreeToggle<CR>
nnoremap <leader>nc :NERDTreeClose<CR>
" }}}

" Syntastic plugin {{{
" Get first pylint to check, then if no errors found, check with pep8
" Check for errors on opening
" Use the location list more
" Jump to first error in file
let g:syntastic_python_checkers=["pylint","pep8"]
let g:syntastic_check_on_open=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=0
" Want this when syntastic is passive, not when active
let g:syntastic_auto_jump=0
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=0
" Get all errors instead of stopping at first error
let g:syntastic_aggregate_errors=1
" Show error in command window
let g:syntastic_echo_current_error=1

" Set syntastic statusline format
let g:syntastic_stl_format='%W{[Warn: %w]}%E{[Err: %e]}'
" Mode of checking
" Leave most files alone - I save a lot
" and pop-ups all the time would get annoying
" Active check ruby and lua - configuration files
" passive => only check when call ':SyntasticCheck'
" active  => check when save and load file
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['ruby', 'lua'],
                            \ 'passive_filetypes': [] }
"
" Map <leader>ok to check the file
nnoremap <leader>ok :SyntasticCheck<CR>
nnoremap <leader>rk :SyntasticReset<CR>
" }}}

" Workspace plugin {{{
" close workspace
let Ws_Exit_Only_Window = 1
let Ws_WinWidth = 20
" }}}

"Surround Plugin {{{
" remove the 's' mapping in visual mode
" xmap <Leader>s <Plug>Vsurround
"}}}

" Buf Explorer Plugin {{{
" Mostly the default options are good
" Just make it shows NoName buffers aswell
let g:bufExplorerShowNoName=1
" }}}

" Taglist Plugin {{{
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
" Opens Taglist and moves to that window
" if are on a tag will open at that tag
nnoremap <F6> :TlistToggle <CR>
" }}}

" Python-mode plugin {{{

" These variables don't matter if don't have python-mode installed

" Disable python folding - Already have a nicer plugin for that
" Though would like to check about this versions docstring handling
let g:pymode_folding = 0
let g:pymode_lint_checker = "pylint,pyflakes,pep8,mccabe"
let g:pymode_lint_cwindow = 0
" let g:pymode_lint_message = 0
" don't automatically call checking - same reason as for syntastic
" don't highlight spaces at end of line - when typing is annoying
let g:pymode_lint_write = 0
let g:pymode_syntax_space_errors=0
let g:pymode_syntax_print_as_function = 1

let g:pymode_run_key='<leader>pr'

"Disable ropevim in favour of jedi vim
let g:pymode_rope=0
" let g:pymode_rope_extended_complete=1
" let g:pymode_rope_enable_autoimport=1

" map pk to run pymode lint
nnoremap <leader>pk :PyLint<CR>
" }}}

" {{{ Jedi vim
let g:jedi#use_tabs_not_buffers=0
let g:jedi#use_splits_not_buffers="right"
" Don't want completeopt overridden - and already have C-c mapped to ESC
let g:jedi#auto_vim_configuration=0
" allow enabling and disabling jedi call signatures
nnoremap [oj  :let g:jedi#show_call_signatures=1<CR>
nnoremap ]oj  :let g:jedi#show_call_signatures=0<CR>
" don't want the docstring popping up all the time
autocmd FileType python setlocal completeopt-=preview
" This can be put in a modeline, or ftplugin file, but I don't want to
" split up plugin options.
" }}}

" {{{ Gundo plugin
nnoremap <F5> :GundoToggle<CR>
let g:gundo_prefer_python3=1
" }}} 

" {{{ CtrlP plugin
" Change where ctrlp opens the files, what file it looks for and how it
" searches
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2tr'
let g:ctrlp_arg_map = 1
let g:ctrlp_extensions = ['dir', 'buffertag', 'tag', 'changes', 'line']
" }}}

" {{{ Fugitive Plugin
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}\ \ \ %{SyntasticStatuslineFlag()}%=%-14.(%l,%c%V%)\ %P
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Printoptions {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"When printing, include numbers
"(only works if compiled with the correct options - not sure that's what's done
set printoptions=number:y
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: foldmethod=marker
