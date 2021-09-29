set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let VUndle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'                 " Default Plugin
Plugin 'blueyed/vim-diminactive'              " split focus highlighting
Plugin 'vim-airline/vim-airline'              " status bar
Plugin 'vim-airline/vim-airline-themes'       " airline themes
Plugin 'majutsushi/tagbar'                    " function, variable navigator
Plugin 'scrooloose/nerdtree'                  " file structure navigator
Plugin 'Xuyuanp/nerdtree-git-plugin'          " nerd tree with git status
Plugin 'xolox/vim-easytags'                   " ctags extension
Plugin 'vim-misc'                             " for easytags dependency
Plugin 'ronakg/quickr-cscope.vim'             " cscope extension
Plugin 'nathanaelkane/vim-indent-guides'      " indent highlighting
"Plugin 'AutoClose'                            " Auto bracket Closing
Plugin 'tComment'                             " easy comment with (ctrl + -) x2
Plugin 'octol/vim-cpp-enhanced-highlight'     " C++ highlighting
Plugin 'airblade/vim-gitgutter'               " git diff marking
" Plugin 'davidhalter/jedi-vim'                 " Python auto-complete
" Plugin 'ervandew/supertab'					  " Python auto-complete with Tab key
Plugin 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plugin 'hynek/vim-python-pep8-indent'         " Python auto-indent
Plugin 'nvie/vim-flake8'                      " Python grammar check

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
"set expandtab             " replace tab to space when saving
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
" === C / C++ ===
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent        " C indent
au BufRead,BufNewFile *.c,*.cpp,*.h set smartindent    " indent disable for preprocessor
au BufRead,BufNewFile *.c,*.cpp,*.h set shiftwidth=2   " indent width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h set tabstop=2      " tab width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h set expandtab      " replace tab to space when saving
" au BufRead,BufNewFile *.c,*.cpp,*.h set shiftwidth=4   " indent width: 2
" au BufRead,BufNewFile *.c,*.cpp,*.h set tabstop=4      " tab width: 2
au BufRead,BufNewFile *.c,*.cpp,*.h call MaxWidth()    " max width: 80 highlighting

" === PYTHON === 

let python_version_3 = 1
let python_highlight_all = 1
" run with python
au FileType python map <f2> : !python3 %

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
" prev/next latest file open key mapping
nmap <leader>q :bp<CR> 
nmap <leader>w :bn<CR>

" ===TAGBAR===
let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'
nmap <F12> :TagbarToggle<CR>

" ===NERDTREE===
nmap <F11> :NERDTreeToggle<CR>
let NERDTreeWinPos = "left"
" open file with enter key: vsplit
let NERDTreeCustomOpenArgs = {'file': {'where': 'v', 'keepopen': 1, 'stay': 1}, 'dir': {}}
" open NERDTree automatically when starting vim (change focus)
autocmd VimEnter * NERDTree  | wincmd p
" exit vim when rest split window is only NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeIgnore = ['\.out$', '\.o$']

" ===INDENT-GUIDE===
let g:indent_guides_enable_on_vim_startup = 1

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

