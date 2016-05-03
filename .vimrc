
set nocompatible
set hidden
filetype off                  

" Alt key solution
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'slim-template/vim-slim'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'joshdick/onedark.vim'
Plugin 'joshdick/airline-onedark.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'tpope/vim-fugitive'

call vundle#end()            

" Cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Save with ctrl s
noremap <A-s>          :update<CR>
vnoremap <A-s>         <C-C>:update<CR>
inoremap <A-s>         <C-O>:update<CR> 

" Quit with ctrl q
noremap <A-q>          :q<CR>
vnoremap <A-q>         <C-C>:q<CR>
inoremap <A-q>         <C-O>:q<CR> 

" Indentation
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set smarttab

" Airline
let g:airline_exclude_preview = 1

" Normal mode remaps
noremap ;           :
noremap o           o<ESC>
noremap O           O<ESC>
noremap <silent> +  :vertical resize +5<CR>
noremap <silent> -  :vertical resize -5<CR>
noremap <silent> <leader>+ :resize +5<CR>
noremap <silent> <leader>- :resize -5<CR>
noremap <C-s>       :w<CR>
noremap <C-d>       dd
noremap <C-f>       /
noremap z           zz
noremap <A-b>       :! node %<CR>
noremap ]           <Up>{<Down>^
noremap [           }<Down>^
noremap gu          vgU
noremap gl          vgu
noremap w           :w<CR>
noremap q           :q<CR>

" Visual mode remaps
vnoremap gu         gU
vnoremap gl         gu
vnoremap gg         g~

" Insert mode remaps
imap jj <ESC>
inoremap <C-d>      <ESC>ddi
inoremap <C-u>      <ESC>ui
inoremap <C-d>      <ESC>ddi
inoremap <C-f>      <ESC> /

" Sublime style parnthesis mappings
inoremap {          {}<Left>
inoremap {<CR>      {<CR>}<ESC>O<TAB>
inoremap <expr> }   strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {<BS>      <nop>
inoremap {{         {

inoremap [          []<Left>
inoremap [<CR>      [<CR>]<ESC>O<TAB>
inoremap <expr> ]   strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap [<BS>      <nop>
inoremap [[         [

inoremap (          ()<Left>
inoremap (<CR>      (<CR>)<ESC>O<TAB>
inoremap <expr> )   strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap ((         (

inoremap "          ""<Left>
inoremap <expr>"    strpart(getline('.'), col('.')-1, 1) == "\"" ? "<Right>" : "\"\"<Left>"
inoremap ""         "

inoremap '          ''<Left>
inoremap <expr>'    strpart(getline('.'), col('.')-1, 1) == "\'" ? "<Right>" : "\'\'<Left>"
inoremap ''         '

inoremap <expr> >   strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

" Reorder lines
nnoremap <A-j>      :m .+1<CR>==
nnoremap <A-k>      :m .-2<CR>==
inoremap <A-j>      <ESC>:m .+1<CR>==gi
inoremap <A-k>      <ESC>:m .-2<CR>==gi
vnoremap <A-j>      :m '>+1<CR>gv=gv
vnoremap <A-k>      :m '<-2<CR>gv=gv

" Reorder words
nnoremap <A-h>      "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-1>
nnoremap <A-l>      "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_\W\+<CR><c-l>

" General
set mouse=a
set showmatch
set nowrap
set autoread
set relativenumber
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

" Tab navigation
nnoremap th         :tabfirst<CR>
nnoremap tj         :tabnext<CR>
nnoremap tk         :tabprev<CR>
nnoremap tl         :tablast<CR>
nnoremap tt         :tabedit<Space>
nnoremap tm         :tabm<Space>
nnoremap tn         :tabnew<CR>

" ctrlP
let g:ctrlp_show_hidden = 1

" Theme
syntax on
colorscheme onedark
let g:airline_theme='onedark'

" NERDTree
map <A-a>           :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMouseMode = 3
let NERDTreeIgnore = [ '\.o$', '\.meta$' ]
autocmd vimenter * if argc() == 0 | NERDTree | endif
nnoremap <leader>n :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h

" CTRLP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)'

" Autoload vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

