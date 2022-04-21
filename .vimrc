set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'                 " Plugin Vundle
Plugin 'scrooloose/nerdtree'                  " file structure navigator
Plugin 'Xuyuanp/nerdtree-git-plugin'          " nerd tree with git status
Plugin 'blueyed/vim-diminactive'              " split focus highlighting
Plugin 'vim-airline/vim-airline'              " status bar & buffer tab
Plugin 'vim-airline/vim-airline-themes'       " airline themes
Plugin 'airblade/vim-gitgutter'               " git diff marking
Plugin 'tComment'                             " easy comment with (ctrl + -) x2

" Language support
Plugin 'nvie/vim-flake8'                      " Python grammar check
Plugin 'hynek/vim-python-pep8-indent'         " Python auto-indent
Plugin 'octol/vim-cpp-enhanced-highlight'     " C++ highlighting
Plugin 'JamshedVesuna/vim-markdown-preview'   " Markdown preview
Plugin 'mattn/emmet-vim'                      " HTML auto-complete (,,)
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'maxmellon/vim-jsx-pretty'

call vundle#end()  " required

" ======================
" |   GLOBAL SETTING   |
" ======================

filetype plugin indent on  " required

command! -bang W w<bang>   " alias :W to :w
command! -bang Q q<bang>   " alias :Q to :q
command! -bang WQ wq<bang> " alias :WQ to :wq
command! -bang Wq wq<bang> " alias :Wq to :Wq

if has("syntax")           " syntax highlighting
    syntax on
endif

set encoding=utf-8         " default encoding: utf-8
set fileencodings=utf-8,cp949,default,latin1
set termencoding=utf-8

set noswapfile             " disable .swp file

set number                 " print line number
set numberwidth=4          " line number column's width

set title                  " print file name int bottom bar
set ruler                  " print cursor location in bottom bar
set laststatus=2           " always show status in bottom bar

set autoindent             " auto indent
set shiftwidth=4           " indent width: 4
set tabstop=4              " tab width: 4
set softtabstop=4          " tab width: 4
set expandtab              " replace tab to space when saving
set nowrap                 " do not auto line breaking
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→ " indicate tab & space

set backspace=indent,eol,start    " enable backspace in insert mode

set hlsearch              " search result highlighting
set incsearch             " search result highlighting update while typing a character
set nowrapscan            " do not search over and over
set ignorecase smartcase  " distinct lower/upper case in search

set synmaxcol=9999        " disable syntax highlighting for performance (large size file)

set showmatch             " highlight matching bracket
set nocursorline          " do not create empty line for cursor locating
set cursorline            " highlight current line

function! MaxWidth()      " function: highlighing for column width (80)
    if exists('+colorcolumn') 
        set colorcolumn=80
    else
        au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80.v\+', -1)
    endif
endfunction

" ======================
" |     FILE TYPES     |
" ======================
"
" ======================
" |     FILE TYPES     |
" ======================
"
" === C / C++ ===
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent           " C indent
au BufRead,BufNewFile *.c,*.cpp,*.h set smartindent       " indent disable for preprocessor
" au BufRead,BufNewFile *.c,*.cpp,*.h set shiftwidth=2      " indent width: 2
" au BufRead,BufNewFile *.c,*.cpp,*.h set tabstop=2         " tab width: 2
" au BufRead,BufNewFile *.c,*.cpp,*.h set expandtab         " replace tab to space when saving
au BufRead,BufNewFile *.c,*.cpp,*.h set shiftwidth=4      " indent width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h set tabstop=4         " tab width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h set softtabstop=4     " tab width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h call MaxWidth()       " max width: 80 highlighting

" === HTML / CSS / Javascript ===
au BufRead,BufNewFile *.html,*.css,*.js set shiftwidth=2  " indent width: 2
au BufRead,BufNewFile *.html,*.css,*.js set tabstop=2     " tab width: 2
au BufRead,BufNewFile *.html,*.css,*.js set softtabstop=2 " tab width: 2
au BufRead,BufNewFile *.html,*.css,*.js set expandtab     " replace tab to space when saving

" === JSON ===
au BufRead,BufNewFile *.json set shiftwidth=2
au BufRead,BufNewFile *.json set tabstop=2
au BufRead,BufNewFile *.json set softtabstop=2
au BufRead,BufNewFile *.json set noexpandtab

" === PYTHON === 
let python_version_3 = 1
let python_highlight_all = 1
" execute python
au FileType python map <f2> : !clear && python3 %<CR>
au BufRead,BufNewFile *.py set shiftwidth=2
au BufRead,BufNewFile *.py set tabstop=2
au BufRead,BufNewFile *.py set softtabstop=2

" ====================
" |      PLUGINS     |
" ====================
let mapleader = ','

" ===JELLYBEANS===
colorscheme jellybeans

" ===DIMINACTIVE===
let g:diminactive_enable_focus = 1

" ===AIRLINE===
let g:airline#extensions#tabline#enabled = 1 " enable buffer list
let g:airline_themes = 'zenburn'
set laststatus=2 " enable bottom bar
" goto previous file buffer
nmap <leader>q :bp<CR> 
" goto next file buffer
nmap <leader>w :bn<CR>
" remove current file buffer
nmap <leader>e :bp\|bd #<CR>

" ===NERDTREE===
nmap <F11> :NERDTreeToggle<CR>
let NERDTreeWinPos = "left"
" open file with enter key: vsplit
let NERDTreeCustomOpenArgs = {'file': {'where': 'v', 'keepopen': 1, 'stay': 1}, 'dir': {}}
" open NERDTree automatically when starting vim (change focus to file)
autocmd VimEnter * NERDTree  | wincmd p
" exit vim when NERDTree exists alone
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeIgnore = ['\.out$', '\.o$']
" prohibit NERDTree window has changed to another buffer file
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" ===GIT-GUTTER===
let g:gitgutter_enabled = 1

" ===CPP-SYNTAX-HIGHLIGHT===
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

" ===jedi-vim===
let g:jedi#show_call_signatures=0  " hide detail explanation
let g:jedi#popup_select_first="0"  " popup disable when auto-complete
let g:jedi#force_py_version=3      " auto-complete with python3

" ===emmet-vim===
let g:user_emmet_leader_key=','    " html auto complete with ,,
let g:loaded_tabline = 0

" ===markdown-preview===
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'

" markdown image format을 html img tag로 변경하며 notion server path에서 local path로 변경하는 함수
function! Img(path)
    :%s/!\[.*\](/\<img src="/g
    :%s/.jpg)/.jpg">/g
    exe ':%s/https:\/\/s3-us-west-2.amazonaws.com\/secure.notion-static.com\/.*\//\/images\/' . a:path . '\//g'
    :%s/\\\//\//g
endfunction

" html img tag에서 width 변경하는 함수
function! Size(width)
    let line = getline('.')
    " let line = join([split(line, '>')[0], '"width=' . a:width . '%">'])
    let line = join([split(split(line, '>')[0], ' width=')[0], 'width="' . a:width . '%">'])
    call setline('.', line)
endfunction

function! Json()
    :%!python3 ~/.vim/json_pretty.py
endfunction
