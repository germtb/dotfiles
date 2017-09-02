syntax enable

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
Plug 'wojtekmach/vim-rename'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-slash'
Plug 'jdkanani/vim-material-theme'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'for': ['js'], 'do': function('BuildYCM') }

call plug#end()

" basic settings
let mapleader      = ' '
let maplocalleader = ' '

augroup vimrc
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

set nu
set nocompatible
set hidden
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set visualbell
filetype off
syntax on
filetype plugin indent on
set modelines=0
set number
set ruler
set visualbell
set nowrap
syntax enable
set pastetoggle=<F2>
set swapfile
set cursorline
set list
set listchars=tab:·\ ,eol:¬,trail:·,nbsp:⎵

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" temporary files
set dir=~/temp
set backupdir=~/temp
set directory=~/temp
if v:version >= 703
  set undodir=~/temp
endif

" mouse
silent! set ttymouse=xterm2
set mouse=a

" theme
syntax enable
set background=dark
colorscheme material-theme

" js
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" remaps
nnoremap <leader>q :q<CR>
nnoremap <leader>w :update<CR>

nnoremap o  o<ESC>
nnoremap O  O<ESC>

noremap ∆  }j
noremap ˚  {k

nnoremap ¬  viw
nnoremap ˙  viw

xnoremap ¬  <ESC>wviw
xnoremap ˙  <ESC>bbviw

inoremap jj <ESC>

" buffers
nnoremap <leader>j :bnext<CR>
nnoremap <leader>k :bprev<CR>

" autocompletion
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" NerdTree
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>m :NERDTreeFind<CR>
let NERDTreeShowHidden=1

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'

noremap <leader>p :Files<CR>
noremap <leader>c :Commands<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>l :Lines<CR>

" multiple-cursors
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_next_key='<C-d>'
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
let g:prettier#config#trailing_comma = 'none'
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
command! Remove execute "call delete(expand('%')) | bdelete!"

" functions
nnoremap <leader>f :call NormalNextToken()<CR>
functio! NormalNextToken()
  :echom  "hello"
  :echom  "hello"
  :echom  "hello"
endfunction

