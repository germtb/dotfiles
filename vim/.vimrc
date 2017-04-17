
execute pathogen#infect()
syntax on
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

" Insert mode
inoremap jj          <ESC>

