set nocompatible

set hidden
filetype on

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
nnoremap ;           :
nnoremap o           o<ESC>
nnoremap O           O<ESC>
nnoremap <silent> +  :vertical resize +5<CR>
nnoremap <silent> -  :vertical resize -5<CR>
nnoremap <silent> <leader>+ :resize +5<CR>
nnoremap <silent> <leader>- :resize -5<CR>
nnoremap gu          vgU
nnoremap gl          vgu
nnoremap w           :w<CR>
nnoremap q           :q<CR>
nnoremap #           :call Comment()<CR>
nnoremap ~           :call Uncomment()<CR>
nnoremap ]           ]]
nnoremap [           [[
nnoremap <S-j>       :call AltDown()<CR>
nnoremap <S-k>       :call AltUp()<CR>
nnoremap ev          :vsplit ~/.vimrc<CR>
nnoremap sv          :source ~/.vimrc<CR>

" Insert mode
inoremap jj <ESC>
inoremap jk <ESC>

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
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMouseMode = 3
let NERDTreeShowLineNumbers=1
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

function! AltUp()
  if line(".") == 1
    return 1
  endif

  if line(".") == 2
    execute "normal! k"
    return 1
  endif

  execute "normal! k{j^"

  if getline(".") == ""
    call AltUp()
  endif

endfunction

function! AltDown()
  if line(".") == line("$")
    return 1
  endif

  execute "normal! }j^"

  if getline(".") == ""
    call AltDown()
  endif

endfunction
