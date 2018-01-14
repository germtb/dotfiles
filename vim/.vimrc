let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'install.sh'
	\ }
Plug 'b4winckler/vim-angry'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-operator-flashy'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinj/vim-textobj-reactprop'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'maximbaz/lightline-ale'
Plug 'mgee/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'osyo-manga/vim-over'
Plug 'othree/jspc.vim'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'rhysd/clever-f.vim'
Plug 'romgrk/replace.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'syngan/vim-vimlint'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'wojtekmach/vim-rename'
Plug 'ynkdir/vim-vimlparser'

call plug#end()

" Basic settings
set nocompatible
set encoding=utf-8
scriptencoding utf-8
set modifiable
set showcmd
set noshowmode
set hidden
set lazyredraw
set laststatus=2
filetype plugin indent on
set number
set visualbell
set nowrap
set pastetoggle=€
set cursorline
set colorcolumn=80

" Language server protocol
let g:LanguageClient_serverCommands = {
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ }

autocmd FileType *.js :setlocal omnifunc=LanguageClient#complete

let g:LanguageClient_autoStart = 1

nnoremap K :LanguageClient_textDocument_hover()<CR>
" autocmd CursorMoved,CursorMovedI *.js :call LanguageClient_textDocument_hover()

nnoremap df :call LanguageClient_textDocument_definition()<CR>
nnoremap rr :call LanguageClient_textDocument_rename()<CR>

" Fugitive
nnoremap gs :Gstatus<CR>
nnoremap gd :Gdiff<CR>
nnoremap gb :Gblame<CR>

" Set leader
let g:mapleader = ' '
let g:maplocalleader = ' '

" newtr
let g:netrw_banner       = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'
autocmd FileType netrw setl bufhidden=delete
autocmd FileType netrw setl bufhidden=wipe

" Deoplete completion
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#max_menu_width = 60

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Replace Operator
nmap R <Plug>ReplaceOperator
vmap R <Plug>ReplaceOperator

" Remove automatic insertion of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Invisible characters
set list
set listchars=tab:→\ ,eol:♫,trail:·,space:·

" Autoreload files
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
	\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Ale
let g:ale_sign_column_always = 0
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
let g:ale_completion_enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Paste
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
set clipboard=unnamedplus
xnoremap y "*y

" Startify
let g:startify_session_persistence = 1

" Lightline
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

" Indentation
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2

" Autoload vimrc
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

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch
autocmd BufReadPre,FileReadPre * :highlight IncSearch guibg=green ctermbg=green term=underline

" Backup files
set swapfile
set dir=~/temp
set backupdir=~/temp
set directory=~/temp
if v:version >= 703
	set undodir=~/temp
endif

" Mouse
silent! set ttymouse=xterm2
set mouse=a

" Theme
syntax enable
set background=dark
colorscheme hybrid_material

" JS
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Maps
" nnoremap <leader>q :q<CR>
" nnoremap <leader>w :update<CR>

" nnoremap o o<ESC>
" noremap O O<ESC>

" noremap ∆ }j
" noremap ˚ {k

" nnoremap ¬ viw
" nnoremap ˙ viw

nnoremap <leader>d "dyiwoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
nnoremap <leader><S-d> "dyiwOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

xnoremap ¬ <ESC>wviw
xnoremap ˙ <ESC>bbviw

xnoremap <leader>d "dyoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
xnoremap <leader><S-d> "dyOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

inoremap jj <ESC>

" vim-over
nnoremap <leader>f /
nnoremap <leader>F yiw/<C-R>"<CR>
nnoremap <leader>s :OverCommandLine<CR>%s/
nnoremap <leader>S yiw:OverCommandLine%s/<C-R>"/

" clever-f
let g:clever_f_show_prompt=1

" NerdTree
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>m :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=0
let g:NERDTreeShowHidden=0

" Replace accross project
function! Replace(pattern, replacement)
	let command = "rg ". a:pattern. " -l | xargs sed -i '' -e 's/". a:pattern. "/". a:replacement. "/g'"
	execute system(l:command)
	execute "normal! :edit<CR>"
	echom l:command
endfunction

command! -nargs=+ Replace call Replace(<f-args>)
nnoremap <leader>r :Replace 
nnoremap <leader>R yiw:Replace <C-R>" 

" Path to clipboard
command! Path :let @*=expand("%")
command! FullPath :let @*=expand("%:p")

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'

nnoremap <leader>p :Files!<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>a :Rg! 
nnoremap <leader>A yiw:Rg! <C-R>"<CR>
vnoremap <leader>a y:Rg! <C-R>"<CR>
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
nnoremap <c-l> i<c-l>

" prettier
let g:prettier#autoformat = 1
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

" Commands
command! Remove execute "call delete(expand('%')) | bdelete!"
command! ReloadConfig execute "source ~/.vimrc"

" Folding
set foldmethod=indent
set foldlevel=99

" term
nnoremap <leader>t :vsplit term://zsh<CR>
tnoremap <leader>q <C-\><C-n>:bd!<CR>
tnoremap jj <C-\><C-n>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
autocmd BufEnter term://* startinsert

" Splits
set splitright
tnoremap <leader>wh <C-\><C-N><C-w>h
tnoremap <leader>wj <C-\><C-N><C-w>j
tnoremap <leader>wk <C-\><C-N><C-w>k
tnoremap <leader>wl <C-\><C-N><C-w>l
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

" Tabs
set showtabline=2

let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_map = {
	\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
	\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" textobj

let s:IMPORT_REGEX = "import .* from '.*'"

call textobj#user#plugin('js', {
\   'import': {
\     'pattern': s:IMPORT_REGEX,
\     'select': ['aI', 'iI'],
\   }
\ })

let g:loaded_textobj_js = 1

" autoclose XML-like tags
let g:closetag_filenames = "*.html,*.jsx,*.js"

