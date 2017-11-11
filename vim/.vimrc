syntax enable

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'chriskempson/base16-vim'
Plug 'othree/jspc.vim'
Plug 'moll/vim-node'
Plug 'wojtekmach/vim-rename'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'maralla/completor.vim'
Plug 'osyo-manga/vim-over'
Plug 'romgrk/replace.vim'
Plug 'b4winckler/vim-angry'

call plug#end()

" CompleteJS
let g:completor_node_binary = '/usr/local/bin/node'
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr> pumvisible() ? "\<C-n>" : "\<cr>"

" set leader
let mapleader      = ' '
let maplocalleader = ' '

" Replace Operator
nmap R <Plug>ReplaceOperator
vmap R <Plug>ReplaceOperator

" basic settings
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
set tabstop=2
set shiftwidth=2
set list
set listchars=tab:·\ ,eol:¬,trail:·

" autoload vimrc
augroup vimrc
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set encoding=utf-8

" search
set ignorecase
set smartcase

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
colorscheme hybrid_material
" colorscheme material-theme

" js
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" nnoremp <leader>j :! babel-node %

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" remaps
nnoremap cc ciw

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

" vim-over
nnoremap <leader>f :OverCommandLine<CR>

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

" commands
command! Remove execute "call delete(expand('%')) | bdelete!"

" functions
" noremap <leader>f :call NormalNextToken()<CR>

functio! NormalNextToken()
  :let tokens=system('~/dev/vim-tokens/index.js')
  :echom tokens
  :echom tokens
  :echom tokens
  :echom tokens
endfunction

function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

