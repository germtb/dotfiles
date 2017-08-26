
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier', { 
	\ 'do': 'yarn install', 
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] } 
Plug 'chriskempson/base16-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'othree/jspc.vim'
Plug 'moll/vim-node'
Plug 'vim-syntastic/syntastic'
Plug 'ap/vim-buftabline'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'for': ['js'], 'do': function('BuildYCM') }

call plug#end()

set nocompatible
filetype off
syntax on
filetype plugin indent on
set modelines=0
set number
set ruler
set visualbell
set mouse=a
set nowrap
syntax enable
set pastetoggle=<F2>

set list
set listchars=tab:·\ ,eol:¬,trail:·,nbsp:⎵

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" theme
syntax enable
set background=dark

" js
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

nnoremap o  o<ESC>
nnoremap O  O<ESC>

nnoremap ∆  }j
nnoremap ˚  {k
nnoremap ¬  viw
nnoremap ˙  viw
nnoremap q  :q<CR>

vnoremap ∆  <ESC>}j
vnoremap ˚  <ESC>{k
vnoremap ¬  <ESC>wviw
vnoremap ˙  <ESC>bbviw

inoremap jj <ESC>

" buffers
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprev<CR>

" autocompletion
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" NerdTree
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter *f argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

noremap <C-n> :NERDTreeToggle<CR>
noremap <C-m> :NERDTreeFind<CR>

" fzf
noremap <C-p> :Files<CR>
noremap <C-c> :Commands<CR>
noremap <C-b> :Buffers<CR>
noremap <C-l> :Lines<CR>

" multiple-cursors
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-S-d>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true' 
let g:prettier#config#bracket_spacing = 'true' 
let g:prettier#config#jsx_bracket_same_line = 'false' 
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#parser = 'flow'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" commands
command Remove execute "call delete(expand('%')) | bdelete!"

