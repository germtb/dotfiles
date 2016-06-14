set nocompatible
filetype off

" Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'vim-expand-region'

call vundle#end()
filetype plugin indent on

filetype on
set hidden

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
nnoremap gu          vgU
nnoremap gl          vgu
nnoremap w           :w<CR>
nnoremap q           :q<CR>
nnoremap #           :call Comment()<CR>
nnoremap ~           :call Uncomment()<CR>
nnoremap J           :call AltDown()<CR>
nnoremap K           :call AltUp()<CR>
nnoremap ev          :vsplit ~/.vimrc<CR>
nnoremap sv          :source ~/.vimrc<CR>
nnoremap z           zz

" Insert mode
inoremap jj          <ESC>
inoremap jk          <ESC>

" Resizing splits
nnoremap <silent> + :vertical resize +5<CR>
nnoremap <silent> - :vertical resize -5<CR>
nnoremap <silent> <leader>+ :resize +5<CR>
nnoremap <silent> <leader>- :resize -5<CR>

" Expand region
map L               <Plug>(expand_region_expand)
map H               <Plug>(expand_region_shrink)

" General
set mouse=a
set showmatch
set nowrap
set autoread
set number
syntax enable
set scrolloff=4
set noswapfile
set noundofile
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
autocmd VimEnter * wincmd p
let NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMouseMode = 3
let NERDTreeShowLineNumbers=1
nnoremap <leader>r        :NERDTreeFind<CR>
nnoremap <leader>n        :NERDTreeToggle<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" CTRLP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)'
let g:ctrlp_show_hidden = 1

" Javascript
" let g:javascript_conceal_function       = "ƒ"
" let g:javascript_conceal_null           = "ø"
" let g:javascript_conceal_this           = "@"
" let g:javascript_conceal_undefined      = "¿"
" let g:javascript_conceal_prototype      = "¶"
" let g:javascript_conceal_super          = "Ω"
" let g:javascript_conceal_arrow_function = "⇒"
" let g:javascript_ignore_javaScriptdoc = 1
" let g:jsx_ext_required = 0

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
