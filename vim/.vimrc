let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'othree/jspc.vim'
Plug 'wojtekmach/vim-rename'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'osyo-manga/vim-over'
Plug 'romgrk/replace.vim'
Plug 'b4winckler/vim-angry'
Plug 'wellle/targets.vim'
Plug 'ap/vim-buftabline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'haya14busa/is.vim'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'w0rp/ale'
Plug 'ynkdir/vim-vimlparser'
Plug 'syngan/vim-vimlint'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-vinegar'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'mhinz/vim-startify'

Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-apple-darwin'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Language server protocol
set hidden

let g:LanguageClient_serverCommands = {
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ }

autocmd FileType *.js :setlocal omnifunc=LanguageClient#complete

let g:LanguageClient_autoStart = 1

autocmd CursorMoved,CursorMovedI *.js :call LanguageClient_textDocument_hover()

nnoremap <CR> :call LanguageClient_textDocument_definition()<CR>
nnoremap rr :call LanguageClient_textDocument_rename()<CR>

" fugitive
nnoremap gl :!git log<CR>
nnoremap gs :Gstatus<CR>
nnoremap gd :Gdiff<CR>
nnoremap gD :!git diff<CR>
nnoremap gB :Gblame<CR>
nnoremap gaa :!git add --all<CR>
nnoremap grr :!git reset .<CR>
nnoremap gpl :!git pull<CR>
nnoremap gpp :Git push origin HEAD<CR>
nnoremap gc :Gcommit<CR>
nnoremap gb :Git branch<CR>
nnoremap gbb :Git branch --all<CR>
nnoremap g- :!git checkout -<CR>
" nnoremap gm :Git checkout master<CR>

" set leader
let g:mapleader = ' '
let g:maplocalleader = ' '

" deoplete completion
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#max_menu_width = 60

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Replace Operator
nmap R <Plug>ReplaceOperator
vmap R <Plug>ReplaceOperator

" basic settings
set nocompatible
set showcmd
set noshowmode
set hidden
set lazyredraw
set laststatus=2
filetype plugin indent on
set number
set visualbell
set nowrap
set pastetoggle=£
set cursorline
set encoding=utf-8
scriptencoding utf-8
set modifiable

" invisible characters
set list
set listchars=tab:→\ ,eol:♫,trail:·,space:·

" autoreload files
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
	\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'

" Paste
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
set clipboard=unnamedplus
xnoremap y "vy

" Startify
let g:startify_session_persistence = 1

" lightline
let g:lightline = {
	\ 	'colorscheme': 'seoul256',
	\ 	'subseparator': { 'left': '⮁', 'right': '⮃' },
	\ 	'active': {
	\ 		'left': [
	\ 			[ 'mode', 'paste' ],
	\ 			[ 'gitbranch', 'readonly', 'filename', 'modified' ]
	\ 		],
	\ 		'right': [
	\ 			[ 'linter_errors', 'linter_warnings', 'linter_ok' ]
	\ 		]
	\ 	},
	\ 	'component_function': {
	\ 		'filename': 'fugitive#head',
	\ 		'gitbranch': 'LightlineFilename',
	\ 	}
	\ }

function! LightlineFilename()
	return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
		\ &filetype ==# 'unite' ? unite#get_status_string() :
		\ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
		\ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:lightline.component_expand = {
	\ 'linter_warnings': 'lightline#ale#warnings',
	\ 'linter_errors': 'lightline#ale#errors',
	\ 'linter_ok': 'lightline#ale#ok',
	\ }

let g:lightline.component_type = {
	\ 'linter_warnings': 'warning',
	\ 'linter_errors': 'error',
	\ }


let g:lightline#ale#indicator_warnings='⚠'
let g:lightline#ale#indicator_errors='ⓧ'
let g:lightline#ale#indicator_ok='✓'

" indentation
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2

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

if !has('gui_running')
	set t_Co=256
endif

" search
set hlsearch
set ignorecase
set smartcase
set incsearch
autocmd BufReadPre,FileReadPre * :highlight IncSearch guibg=green ctermbg=green term=underline

" swp files
set swapfile
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

" js
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" maps
nnoremap cc ciw

nnoremap <leader>q :q<CR>
nnoremap <leader>w :update<CR>

nnoremap o o<ESC>
noremap O O<ESC>

noremap ∆ }j
noremap ˚ {k

nnoremap ¬ viw
nnoremap ˙ viw

nnoremap <leader>d "dyiwoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
nnoremap <leader><S-d> "dyiwOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

xnoremap ¬ <ESC>wviw
xnoremap ˙ <ESC>bbviw

xnoremap <leader>d "dyoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
xnoremap <leader><S-d> "dyOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

inoremap jj <ESC>

" vim-over
nnoremap <leader>f :OverCommandLine<CR>%s/

" clever-f
let g:clever_f_show_prompt=1

" NerdTree
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>m :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=0
let g:NERDTreeShowHidden=0

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'

nnoremap <leader>p :Files!<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>a :Rg! 
nnoremap <leader>g :GFiles?!<CR>

command! -bang Colors
	\ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'preview': 'rougify {}' }), <bang>0)

command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\ 	'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
	\ 	<bang>0
	\ 		? fzf#vim#with_preview('up:60%')
	\ 		: fzf#vim#with_preview('right:50%:hidden', '?'),
	\ 	<bang>0
	\ )

" fzf completions
inoremap <expr> <c-l> fzf#complete('rg "^.*$" --no-filename --no-line-number')
nmap <c-l> i<c-l>

" prettier
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
autocmd BufWritePre *.js,*.json PrettierAsync

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

" folding
set foldmethod=indent
set foldlevel=99

" term
:tnoremap <Esc> <C-\><C-n>
:tnoremap <leader>wh <C-\><C-N><C-w>h
:tnoremap <leader>wj <C-\><C-N><C-w>j
:tnoremap <leader>wk <C-\><C-N><C-w>k
:tnoremap <leader>wl <C-\><C-N><C-w>l
:inoremap <leader>wh <C-\><C-N><C-w>h
:inoremap <leader>wj <C-\><C-N><C-w>j
:inoremap <leader>wk <C-\><C-N><C-w>k
:inoremap <leader>wl <C-\><C-N><C-w>l
:nnoremap <leader>wh <C-w>h
:nnoremap <leader>wj <C-w>j
:nnoremap <leader>wk <C-w>k
:nnoremap <leader>wl <C-w>l

