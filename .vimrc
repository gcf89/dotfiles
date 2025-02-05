set nocompatible " be iMproved, required
filetype off     " required

"================================================================================
" Usage
"================================================================================

" VIMGREP + QUICKFIX
" allows to find patterns in % or * and populate extra buffer with links
" :vimgrep /pattern/g % or <file>

" REREAD CONFIG file while editing it
" :so %

" filetype change (for vim-commentary plugin i.e.)
" set filetype=html


"================================================================================
" Vundle settings START
"================================================================================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required

" --------------------------------------------------------------------------------
" Bells and whistles
" --------------------------------------------------------------------------------
Plugin 'vim-airline/vim-airline'        " Lean & mean status/tabline for vim that's light as air
Plugin 'rafi/awesome-vim-colorschemes'  " Color schemes

" --------------------------------------------------------------------------------
" Code/project navigation
" --------------------------------------------------------------------------------
" F4
Plugin 'scrooloose/nerdtree'

" TaskList
Plugin 'fisadev/FixedTaskList.vim'

" ysiw" - word
" cs"' - replace " with '
" S" - in visual mode
Plugin 'tpope/vim-surround'

" :CtrlP <starting dir>
" WARN: very slow 
Plugin 'ctrlpvim/ctrlp.vim'             

" Shows indent symbols. Very usefull for bash, python
Plugin 'Yggdroot/indentLine'            

" Syntax checking plugin for Vim
" Depends on 'shellcheck' package
" Plugin 'scrooloose/syntastic'           

" Normal mode: gcc
" Visual mode: gc
Plugin 'tpope/vim-commentary'

" --------------------------------------------------------------------------------
" Python
" --------------------------------------------------------------------------------
Plugin 'mitsuhiko/vim-jinja'            " Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

" --------------------------------------------------------------------------------
"  Unused
" --------------------------------------------------------------------------------
"Plugin 'davidhalter/jedi-vim'           " Awesome Python autocompletion with VIM
"Plugin 'klen/python-mode'               " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
"Plugin 'vim-airline/vim-airline-themes' " Themes for vim-airline
" Nerd tree and CtrlP are more convinient
"Plugin 'Shougo/unite.vim'               " Navigation between buffers and files
" ConqueTerm not working
"Plugin 'rosenfeld/conque-term'          " Consoles as buffers
" requires: apt-get install ack-grep
" ack-grep is installed, but Ack command is not found in Vim
"Plugin 'mileszs/ack.vim'                " Programmers alternate to grep
" not working, smth about generation code structure...
"Plugin 'mitsuhiko/vim-sparkup'          " Sparkup (XML/jinja/htlm-django/etc.) support

call vundle#end() " required

"================================================================================
" Vundle settings END
"================================================================================

filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
" General settings
"=====================================================
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set backspace=indent,eol,start
" This must happen before the syntax system is enabled
aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
set mousemodel=popup

" Activate a permanent ruler and add line highlightng as well as numbers.
" Also disable the sucking pydoc preview window for the omni completion
" and highlight current line and disable the blinking cursor.
set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
    set cursorline
endif
set ttyfast

colorscheme desert
" colorscheme atom
" colorscheme OceanicNext
" set guifont=Consolas:h13
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
set guifont=Mono\ 11

" Enable Syntax Colors
" in GUI mode we go with fruity and Monaco 13
" in CLI mode myterm looks better (fruity is GUI only)
syntax on
if has("gui_running")
    " set macmeta " comment this line if you're not using Mac OS
    set lines=50 columns=125
endif
" special settings for vim
if has("mac")
    let macvim_hig_shift_movement = 1
endif

tab sball
set switchbuf=useopen

" Use system clipboard
set clipboard=unnamedplus

" Customize the wildmenu
set wildmenu
set wildignore+=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class,*/*.dSYM/*,*.dylib
set wildmode=list:full

" Don't bell and blink
set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell
set enc=utf-8           " utf-8 default encoding
set ls=2                " always show status bar
set incsearch           " incremental search
set hlsearch            " highlighted search results
set nu                  " line numbers
set scrolloff=5         " keep some more lines for scope
set showmatch           " show matching brackets/parenthesis
set matchtime=0         " don't blink when matching

" Swaps and backups
if has("win32") || has("win64")
    set dir=$TMP
    set backupdir=$TMP
else
    set dir=/tmp
    set backupdir=/tmp
endif

" Hide some panels
set guioptions-=m  " remove menu bar
set guioptions-=T   " remove toolbar
set guioptions-=r  " remove right-hand scroll bar

" Tab settings
" количество пробелов, которыми символ табуляции отображается в тексте
set tabstop=4
" количество пробелов, которыми символ табуляции отображается при добавлении
set softtabstop=4
" регулирование ширины отступов в пробелах, добавляемых командами >> и <<
set shiftwidth=4
" нажатие Tab в начале строки приведет к добавлению отступа, ширина которого соответствует shiftwidth
set smarttab
" в режиме вставки заменяет символ табуляции на соответствующее количество пробелов
set expandtab
" копирует отступы с текущей строки при добавлении новой + автоматически выставляет отступы в «нужных» местах
set smartindent

"================================================================================
" Plugin configuration
"================================================================================

"NERDTree
map <F4> :NERDTreeToggle<CR>    " browse the list of files in the current directory
let NERDTreeShowHidden=1

" ConqueTerm
nnoremap <F8> :ConqueTermSplit ipython<CR> " run python-scripts at <F5>
nnoremap <F9> :exe "ConqueTermSplit ipython " . expand("%")<CR> " and debug-mode for <F6>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0

" Jedi-vim
let g:jedi#show_call_signatures = 1 " Show call signatures
let g:jedi#popup_on_dot = 1         " Enable autocomplete on dot
let g:jedi#popup_select_first = 0   " Disable first select from auto-complete

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
noremap <f7> :w<CR>:SyntasticCheck<CR>

" Better :sign interface symbols
let g:syntastic_error_symbol = 'X'
let g:syntastic_style_error_symbol = 'X'
let g:syntastic_warning_symbol = 'x'
let g:syntastic_style_warning_symbol = 'x'

"=====================================================
" Python-mode settings
"=====================================================
" Python-mode
" Activate rope
" Keys:
" K Show python docs
" <Ctrl-Space> Rope autocomplete
" <Ctrl-c>g Rope goto definition
" <Ctrl-c>d Rope show documentation
" <Ctrl-c>f Rope find occurrences
" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[ Jump on previous class or function (normal, visual, operator modes)
" ]] Jump on next class or function (normal, visual, operator modes)
" [M Jump on previous class or method (normal, visual, operator modes)
" ]M Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pylint', 'pep8']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore="E501,W601,C0110,C0111"
let g:pymode_lint_write = 0

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Get possibility to run Python code
"let g:pymode_run = 0

" Other options
let g:pymode_options_colorcolumn = 0
"if has("gui_running")
"    let g:airline_powerline_fonts = 1
"else
"    let g:airline_powerline_fonts = 0
"endif

"=====================================================
" User hotkeys
"=====================================================
" Toggle paste mode
set pastetoggle=<F12>

" Easier moving of code blocks
vnoremap < <gv " Shift+> keys
vnoremap > >gv " Shift+< keys

" Backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-Z is Undo
" noremap <C-z> u
" inoremap <C-z> <C-O>u

" CTRL-Y is Redo
noremap <C-y> <C-R>
inoremap <C-y> <C-O><C-R>

" CTRL-A is Select all
"noremap <C-a> gggH<C-O>G
"inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-a> <C-C>gggH<C-O>G
"onoremap <C-a> <C-C>gggH<C-O>G
"snoremap <C-a> <C-C>gggH<C-O>G
"xnoremap <C-a> <C-C>ggVG

" CTRL-S is Quicksave command
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

" Settings for buffers
map <C-q> :bd<CR>         " close current buffer
noremap <C-Right> :bn<CR> " move to next buffer
noremap <C-Left> :bp<CR>  " move to previous buffer

" Easier split navigations
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Easier change size for splitted windows
nnoremap <M-[> :vertical resize +5<cr>
nnoremap <M-]> :vertical resize -5<cr>

" Activate autocomplete at <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

" Generate and insert UUID4 into code by <F12> key
" Disabled in favour to 'pastetoggle'
" nnoremap <F12> :call InsertUUID4()<CR>

" Python code check on PEP8
"autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|iso|zip|tar|tar.gz|tgz|rpm)$',
  \ }

" Ignore files in .gitignore
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"let g:ctrlp_user_command = 'find -L %s -type f'
let g:ctrlp_user_command = 'find -L %s -path "*.git" -prune -o -type f'

"=====================================================
" Languages support
"=====================================================

" --- Python ---
"let python_highlight_all=1
"let python_highlight_exceptions=0
"let python_highlight_builtins=0
"let python_slow_sync=1
"autocmd FileType python setlocal completeopt-=preview
"autocmd FileType python setlocal expandtab shiftwidth=2 tabstop=2
"\ formatoptions+=croq softtabstop=2 smartindent
"\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"let g:syntastic_python_checkers = ['flake8', 'python']
"let g:syntastic_python_flake8_args='--ignore=E121,E128,E711,E301,E261,E241,E124,E126,E721
"\ --max-line-length=80'

" --- Vim ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" --- template language support (SGML / XML too) ---
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-e> <Plug>SparkupExecute
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-l> <Plug>SparkupNext
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
let html_no_rendering=1
let g:syntastic_html_checkers = []

" --- Yaml ---
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- Jinja ---
" au BufNewFile,BufRead *.j2 set ft=jinja
" autocmd FileType jinja setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
" WARN: possible broken config
" autocmd FileType jinja setlocal commentstring=


"================================================================================
" User functions
"================================================================================
  
" Small helper that inserts a random uuid4
" function! InsertUUID4()
" python << endpython
" if 1:
"     import uuid, vim
"     s = str(uuid.uuid4())
"     cpos = vim.current.window.cursor
"     cline = vim.current.line
"     vim.current.line = cline[:cpos[1] + 1] + s + cline[cpos[1] + 1:]
"     vim.current.window.cursor = (cpos[0], cpos[1] + len(s))
" endpython
" endfunction

" Better use :term or :shell
" command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
" function! s:RunShellCommand(cmdline)
"   echo a:cmdline
"   let expanded_cmdline = a:cmdline
"   for part in split(a:cmdline, ' ')
"      if part[0] =~ '\v[%#<]'
"         let expanded_part = fnameescape(expand(part))
"         let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
"      endif
"   endfor
"   botright new
"   setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
"   call setline(1, 'You entered:    ' . a:cmdline)
"   call setline(2, 'Expanded Form:  ' .expanded_cmdline)
"   call setline(3,substitute(getline(2),'.','=','g'))
"   execute '$read !'. expanded_cmdline
"   setlocal nomodifiable
"   1
" endfunction

