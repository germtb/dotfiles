call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh'
	\ }
Plug 'b4winckler/vim-angry'
Plug 'Galooshi/vim-import-js'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-operator-flashy'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinj/vim-textobj-reactprop'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'maximbaz/lightline-ale', { 'for': 'javascript' }
Plug 'mgee/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'osyo-manga/vim-over'
Plug 'othree/jspc.vim'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'on': [ 'PrettierAsync' ] }
Plug 'romgrk/replace.vim'
Plug 'ryanoasis/vim-devicons', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'syngan/vim-vimlint'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary', { 'on': [] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': 'javascript' }
Plug 'wellle/targets.vim'
Plug 'wojtekmach/vim-rename'
Plug 'ynkdir/vim-vimlparser'

call plug#end()

" Lazy loaded plugins
augroup lazy_load_on_insert
	autocmd!
	autocmd InsertEnter * call deoplete#enable() | autocmd! lazy_load_on_insert
augroup END

augroup lazy_load_on_vim_enter
	autocmd!
	autocmd VimEnter * call plug#load('vim-commentary') | autocmd! lazy_load_on_vim_enter
augroup END

" Basic settings
set encoding=utf-8
scriptencoding utf-8
set modifiable
set showcmd
set noshowmode
set hidden
set lazyredraw
set laststatus=2
set number
set visualbell
set nowrap
set pastetoggle=€
set cursorline
set colorcolumn=80
set signcolumn=yes
set grepprg=rg\ --vimgrep

" html
let g:html_indent_inctags = "html,body,head"

" js imports
nnoremap <leader>iw :ImportJSWord<CR>
nnoremap <leader>if :ImportJSFix
" autocmd BufWritePre *.js ImportJSFix

" Git
nnoremap <leader>gp :GFiles!?<CR>
nnoremap <leader>gc :Commits!<CR>

nmap gj <Plug>GitGutterNextHunk
nmap gk <Plug>GitGutterPrevHunk

nmap <leader>ga <Plug>GitGutterStageHunk
nmap <leader>gr <Plug>GitGutterUndoHunk

omap ig <Plug>GitGutterTextObjectInnerPending
omap ag <Plug>GitGutterTextObjectOuterPending
xmap ig <Plug>GitGutterTextObjectInnerVisual
xmap ag <Plug>GitGutterTextObjectOuterVisual

let g:gitgutter_grep_command = 'rg'

" Language server protocol
let g:LanguageClient_serverCommands = {
	\ 'javascript': ['javascript-typescript-stdio'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ 'c': ['cquery --language-server'],
	\ }
" let g:LanguageClient_loggingLevel = 'DEBUG'

autocmd FileType *.js :setlocal omnifunc=LanguageClient#complete

let g:LanguageClient_autoStart = 1

nnoremap K :call LanguageClient_textDocument_hover()<CR>
nnoremap df :call LanguageClient_textDocument_definition()<CR>
nnoremap rr :call LanguageClient_textDocument_rename()<CR>

" Fugitive
nnoremap gs :Gstatus<CR>
nnoremap gd :Gdiff<CR>
nnoremap gb :Gblame<CR>

" Set leader
let g:mapleader = ' '
let g:maplocalleader = ' '

" Deoplete completion
let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"

" deoplete is lazy loaded so enable_at_startup should be disabled
let g:deoplete#enable_at_startup = 0
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#max_menu_width = 60

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? deoplete#mappings#close_popup() : "\n"
endfunction

" Replace Operator
nmap R <Plug>ReplaceOperator
xmap R <Plug>ReplaceOperator

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
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
let g:ale_completion_enabled = 1
nnoremap <silent> <leader>ej :call ale#loclist_jumping#Jump('after', 0)<CR>
nnoremap <silent> <leader>ek :call ale#loclist_jumping#Jump('before', 0)<CR>

" Paste
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
set clipboard=unnamedplus
xnoremap y "*y

" Startify
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
let g:startify_restore_position = 1

autocmd VimLeavePre * call PathSave()
" autocmd BufReadPre,FileReadPre * call PathLoad()

function! PathSave()
	let l:cwd = join(split(getcwd(), '/'), '-')
	execute 'SSave! '.l:cwd
endfunction

function! PathLoad()
	let l:cwd = join(split(getcwd(), '/'), '-')
	execute 'SLoad '.l:cwd
endfunction

" Lightline
let g:lightline = {
	\ 	'colorscheme': 'seoul256',
	\ 	'subseparator': { 'left': '|', 'right': '|' },
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

" Backup files
set swapfile
set dir=~/temp
set backupdir=~/temp
set directory=~/temp
set undodir=~/temp

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
nnoremap <leader>qq :q<CR>
nnoremap <leader>dq :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>db :bd<CR>
nnoremap <leader>dB :bufdo bd<CR>

nnoremap Q @q

nnoremap o o<ESC>
noremap O O<ESC>

noremap ∆ }j
noremap ˚ {k

nnoremap <leader>jd "dyiwoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
nnoremap <leader>jD "dyiwOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
xnoremap <leader>jd "dyoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
xnoremap <leader>jD "dyOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

inoremap jj <ESC>

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch
nnoremap . .:set hlsearch<CR>
nnoremap u u:set hlsearch<CR>

autocmd BufReadPre,FileReadPre * :highlight IncSearch guibg=green ctermbg=green term=underline

command! SearchWordUnderCursor normal! yiw/<C-R>"<CR>
command! FindWordUnderCursor normal! yiw:Find! <C-R>"<CR>

nnoremap <leader>ff /
nnoremap <leader>fF :SearchWordUnderCursor<CR>
nnoremap <leader>fs :OverCommandLine<CR>%s/
nnoremap <leader>fS yiw:OverCommandLine<CR>%s/<C-R>"/
nnoremap <leader>fa :Find! 
nnoremap <leader>fA :FindWordUnderCursor<CR>
nnoremap <leader>fp :Files!<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fh :Helptags<CR>

command! -bang -nargs=* Find
	\ call fzf#vim#grep(
	\ 	'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
	\ 	<bang>0
	\ 		? fzf#vim#with_preview('up:60%')
	\ 		: fzf#vim#with_preview('right:50%:hidden', '?'),
	\ 	<bang>0
	\ )

" NerdTree
noremap <leader>nt :NERDTreeToggle<CR>
noremap <leader>nr :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=0
let g:NERDTreeShowHidden=0

" MassReplace accross project
function! MassReplace(pattern, replacement)
	let command = "rg ". a:pattern. " -l | xargs sed -i '' -e 's/". a:pattern. "/". a:replacement. "/g'"
	execute system(l:command)
	execute "normal! :bufdo edit<CR>"
	echom l:command
endfunction

command! -nargs=+ MassReplace call MassReplace(<f-args>)

" fzf
let g:fzf_commands_expect = 'alt-enter'

nmap <leader> <Plug>(fzf-maps-n)
xmap <leader> <Plug>(fzf-maps-x)
omap <leader> <Plug>(fzf-maps-o)

nnoremap <leader>r :History:<CR>

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'preview': 'rougify {}' }), <bang>0)

" advanced autocompletion
inoremap <expr> <C-l> fzf#complete('rg "^.*$" --no-filename --no-line-number')
imap <C-p> <plug>(fzf-complete-path)
imap <C-f> <plug>(fzf-complete-file-ag)

" prettier
let g:prettier#autoformat = 1
let g:prettier#quickfix_enabled = 0
autocmd BufWritePre *.js,*.json,*.html PrettierAsync

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'flow'

" Remove file
command! Remove execute "call delete(expand('%')) | bdelete!"

" Reload vimrc
command! ReloadVimrc execute "source ~/.vimrc"

" Path to clipboard
command! Path :let @*=expand("%")
command! FullPath :let @*=expand("%:p")

nnoremap <leader>yp :Path<CR>
nnoremap <leader>yP :FullPath<CR>

" Folding
set foldmethod=indent
set foldlevel=99

" term
nnoremap <leader>t :vsplit term://zsh<CR>
tnoremap <leader>qq <C-\><C-n>:bd!<CR>
tnoremap jj <C-\><C-n>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
autocmd BufEnter term://* startinsert

" Splits
set splitright
set splitbelow

nnoremap <leader><tab> :bp<CR>

tnoremap <leader>wh <C-\><C-N><C-w>h
tnoremap <leader>wj <C-\><C-N><C-w>j
tnoremap <leader>wk <C-\><C-N><C-w>k
tnoremap <leader>wl <C-\><C-N><C-w>l

nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

nnoremap <leader>wL :vnew<CR>
nnoremap <leader>wJ :new<CR>

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

