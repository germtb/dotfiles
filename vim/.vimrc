syntax enable

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'othree/jspc.vim'
Plug 'wojtekmach/vim-rename'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'maralla/completor.vim'
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
Plug 'vim-syntastic/syntastic'
Plug 'moll/vim-node'
Plug 'ynkdir/vim-vimlparser'
Plug 'syngan/vim-vimlint'
Plug 'rhysd/clever-f.vim'

 
call plug#end()

" CompleteJS
let g:completor_node_binary = '/usr/local/bin/node'
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr> pumvisible() ? "\<C-n>" : "\<cr>"

" set leader
let g:mapleader = ' '
let g:maplocalleader = ' '

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
set visualbell
syntax on
filetype plugin indent on
set number
set visualbell
set nowrap
syntax enable
set pastetoggle=<F2>
set swapfile
set cursorline
set list
set encoding=utf-8
scriptencoding utf-8
set listchars=tab:→\ ,eol:♫,trail:·,space:·
set autoread

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

" Paste
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
" set clipboard=unnamedplus

" Statusline
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 		[ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head'
	\ },
	\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
	\ }

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

nnoremap o  o<ESC>
noremap O  O<ESC>

noremap ∆  }j
noremap ˚  {k

nnoremap ¬  viw
nnoremap ˙  viw

nnoremap <leader>d "dyiwoconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>
nnoremap <leader><S-d> "dyiwOconsole.log('<ESC>"dpa: ', <ESC>"dpa)<ESC>

xnoremap ¬  <ESC>wviw
xnoremap ˙  <ESC>bbviw

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
let g:NERDTreeShowHidden=0

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'

nnoremap <leader>p :Files<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>a :Ag 
nnoremap <leader>g :GFiles?<CR>

command! -bang Colors
	\ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'preview': 'rougify {}' }), <bang>0)

command! -bang -nargs=* Ag
	\ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
inoremap <expr> <c-l> fzf#complete('ag "^.*$" --nofilename --ignore ".git/" --ignore "node_modules/"')
inoremap <expr> <c-i> fzf#complete('ag "import.*from" --nofilename --ignore ".git/" --ignore "node_modules/"')

" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.html,*.css,*.scss,*.less,*.graphql PrettierAsync

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

" functions
noremap <leader>t :call NormalNextToken()<CR>

let g:ignoredTokens = ['(', ')']

function! GetSelection()
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction

function! NormalNextToken()
	normal! viw
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	let selection = join(lines, "\n")
	" let selection = GetSelection()
	:echom selection
	:echom selection
	:echom selection
endfunction

function! VisualNextToken()
	
endfunction

