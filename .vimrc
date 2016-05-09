set nocompatible
set hidden
filetype off

" Pathogen
execute pathogen#infect()
filetype plugin indent on

" Cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Indentation
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smarttab

" Normal mode
noremap ;           :
noremap o           o<ESC>
noremap O           O<ESC>
noremap <silent> +  :vertical resize +5<CR>
noremap <silent> -  :vertical resize -5<CR>
noremap <silent> <leader>+ :resize +5<CR>
noremap <silent> <leader>- :resize -5<CR>
noremap <A-b>       :! node %<CR>
noremap ]           <Up>{<Down>^
noremap [           }<Down>^
noremap gu          vgU
noremap gl          vgu
noremap w           :w<CR>
noremap q           :q<CR>
noremap #           ^i#<Space><ESC>j
noremap ~           ^xxk
noremap ]           <Up>{<Down>^
noremap [           }<Down>^

" Insert mode
imap jj <ESC>

" General
set mouse=a
set showmatch
set nowrap
set autoread
set number
syntax enable
set scrolloff=4
set noswapfile
set colorcolumn=81
set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set nobackup
set pastetoggle=<F2>
set hlsearch
set incsearch
set listchars=eol:¬,tab:——,trail:·,extends:>,precedes:<
set list

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <A-a>           :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMouseMode = 3
let NERDTreeIgnore = [ '\.o$', '\.meta$' ]
nnoremap <leader>n :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h

" CTRLP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)'
let g:ctrlp_show_hidden = 1
