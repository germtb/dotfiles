set nocompatible

filetype plugin on
filetype indent on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'Valloric/YouCompleteMe'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tmsvg/pear-tree'
Plug 'dense-analysis/ale'
Plug 'tomasiser/vim-code-dark'
Plug 'wokalski/autocomplete-flow'
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/AutoClose'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeFind' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {
     \ 'do': 'yarn install',
     \ 'branch': 'release/1.x',
     \ 'for': [
     \ 'javascript',
     \ 'css',
     \ 'less',
     \ 'scss',
     \ 'json',
     \ 'graphql',
     \ 'markdown',
     \ 'vue',
     \ 'lua',
     \ 'php',
     \ 'python',
     \ 'ruby',
     \ 'html',
     \ 'swift' ] }

call plug#end()

syntax enable

" Basic settings
colorscheme codedark
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
set autoread
set rtp+=/usr/local/opt/fzf
set ttimeout
set timeoutlen=1000 ttimeoutlen=0

" Set leader
let g:mapleader = ' '
let g:maplocalleader = ' '
let mapleader = " "

" Invisible characters
set list
set listchars=tab:→\ ,eol:♫,trail:·,space:·

" Indentation
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

" Rust
let g:rust_recommended_style = 0

" Mouse
silent! set ttymouse=xterm2
set mouse=a

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Remove automatic insertion of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Autoreload files
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
     \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Lightline
let g:lightline = {
     \      'colorscheme': 'codedark',
     \      'subseparator': { 'left': '|', 'right': '|' },
     \      'active': {
     \          'left': [
     \              [ 'mode', 'paste' ],
     \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
     \          ],
     \          'right': [
     \              [ 'linter_errors', 'linter_warnings', 'linter_ok' ]
     \          ]
     \      },
     \      'component_function': {
     \          'filename': 'fugitive#head',
     \          'gitbranch': 'LightlineFilename',
     \      }
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

" Ale
let g:ale_linters = {'javascript': ['eslint', 'flow-language-server']}
let g:ale_fixers = {'javascript': ['eslint', 'prettier']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" instead of having ~/.vim/coc-settings.json
let s:LSP_CONFIG = {
     \  'flow': {
     \    'command': exepath('flow'),
     \    'args': ['lsp'],
     \    'filetypes': ['javascript', 'javascriptreact'],
     \    'initializationOptions': {},
     \    'requireRootPattern': 1,
     \    'settings': {},
     \    'rootPatterns': ['.flowconfig']
     \  }
     \}


" Maps

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

nnoremap o o<ESC>
noremap O O<ESC>

noremap ∆ }j
noremap ˚ {k

inoremap jj <ESC>

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

if has("gui_running")
 set guioptions-=T
 set guioptions-=e
 set t_Co=256
 set guitablabel=%M\ %t
endif

" prettier
let g:prettier#autoformat = 1
let g:prettier#quickfix_enabled = 0
autocmd BufWritePre .js,.json,*.html PrettierAsync

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#trailing_comma = 'none'

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch
nnoremap . .:set hlsearch<CR>
nnoremap u u:set hlsearch<CR>

command! -bang -nargs=* Find
     \ call fzf#vim#grep(
     \      'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
     \      <bang>0
     \          ? fzf#vim#with_preview('up:60%')
     \          : fzf#vim#with_preview('right:50%:hidden', '?'),
     \      <bang>0
     \ )

autocmd BufReadPre,FileReadPre * :highlight IncSearch guibg=green ctermbg=green term=underline

command! FindWordUnderCursor normal! yiw:Find <C-R>"<CR>

command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'preview': 'rougify {}' }), <bang>0)

command! FilesUnderCursor normal! yiw:Files <C-R>"<CR>

" fzf"

nnoremap <leader>c :Commands<CR>
nnoremap <leader>r :History:<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>P :FilesUnderCursor<CR>
nnoremap <leader>f :Find 
nnoremap <leader>F :FindWordUnderCursor<CR>

" NerdTree
noremap <leader>o :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=1
let g:NERDTreeShowHidden=1

" fzf
let g:fzf_commands_expect = 'alt-enter'

nnoremap <leader>h :History:<CR>

" Rust
command! WasmBuild execute "!wasm-pack build --target web"

" Remove file
command! Remove execute "call delete(expand('%')) | bdelete!"

" Reload vimrc
command! ReloadVimrc execute "source ~/.vimrc"

" Path to clipboard
command! Path :let @*=expand("%")
command! FullPath :let @*=expand("%:p")

" Folding
set foldmethod=indent
set foldlevel=99

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

