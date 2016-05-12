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
noremap ]           <Up>{<Down>^
noremap [           }<Down>^
noremap gu          vgU
noremap gl          vgu
noremap w           :w<CR>
noremap q           :q<CR>
noremap #           :call Comment()<CR>
noremap ~           :call Uncomment()<CR>
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
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMouseMode = 3
let NERDTreeIgnore = [ '\.o$', '\.meta$' ]
autocmd vimenter * if argc() == 0 ! NERDTRee endif
nnoremap <leader>r        :NERDTreeFind<CR>
nnoremap <leader>n        :NerdTreeToggle<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" CTRLP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)'
let g:ctrlp_show_hidden = 1

" Functions
function! Comment()
  set paste
  execute "normal! ^"
  let line=getline(".")
  let char=line[col(".")-1]

  if char != "#" && line != ""
    execute "normal! i# "
  endif

  execute "normal! j"
  set nopaste
endfunction

function! Uncomment()
  execute "normal! ^"
  let char=getline(".")[col(".")-1]

  if char == "#"
    execute "normal! xx"
  endif

  execute "normal! k"
endfunction

function! CommentChar()
  return "#"
endfunction
