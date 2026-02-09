"filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmsvg/pear-tree'
Plug 'dense-analysis/ale'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'thinca/vim-qfreplace'
Plug 'lambdalisue/vim-nerdfont'
Plug 'lambdalisue/vim-fern'
Plug 'lambdalisue/vim-fern-renderer-nerdfont'
Plug 'lambdalisue/vim-fern-git-status'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()

syntax enable

" Basic settings
colorscheme sonokai
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
set cursorline
set colorcolumn=80
set signcolumn=yes
set grepprg=rg\ --vimgrep
set rtp+=/usr/local/opt/fzf

" Cursor shape
if exists('$TERM')
  let &t_SI = "\e[6 q"   " Insert mode – bar cursor
  let &t_EI = "\e[2 q"   " Normal mode – block cursor
  let &t_SR = "\e[4 q"   " Replace mode – underline cursor (optional)
endif

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Faster key timeout
set timeoutlen=500
set ttimeoutlen=0

" Better search path
set path+=**

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" Don't clutter working directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Set leader
let mapleader = ' '

" Invisible characters
set list
set listchars=tab:→\ ,trail:·,nbsp:␣,space:·

" Indentation
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab

" Mouse
silent! set ttymouse=sgr
set mouse=a

" Remove automatic insertion of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Autoreload files
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
	 \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" GitGutter - disable default mappings to avoid <leader>h conflict
let g:gitgutter_map_keys = 0

" Ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

let g:ale_fixers = {
      \    'javascript': ['eslint', 'prettier'],
      \    'typescript': ['eslint', 'prettier'],
      \    'css': ['stylelint', 'prettier'],
      \    'html': ['prettier'],
      \    'go': ['gofmt', 'goimports'],
      \    'python': ['ruff']
      \}

" use eslint for ts and js
let g:ale_linters = {
      \    'typescript': [ 'eslint' ],
      \    'javascript': [ 'eslint' ],
      \    'go': ['gopls', 'govet'],
      \    'python': ['pyright', 'ruff']
      \}

" Lightline with bufferline
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

" Lightline-bufferline settings
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_map = {
      \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
      \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
      \ }

" Maps

function! Diffusion()
 let l:filename = expand('%:p')
 let l:line = line('.')
 execute "! open $(diffusion " . l:filename . " -l " . l:line . ")"
endfunction

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" Buffer switching by number
nmap <leader>1 <Plug>lightline#bufferline#go(1)
nmap <leader>2 <Plug>lightline#bufferline#go(2)
nmap <leader>3 <Plug>lightline#bufferline#go(3)
nmap <leader>4 <Plug>lightline#bufferline#go(4)
nmap <leader>5 <Plug>lightline#bufferline#go(5)
nmap <leader>6 <Plug>lightline#bufferline#go(6)
nmap <leader>7 <Plug>lightline#bufferline#go(7)
nmap <leader>8 <Plug>lightline#bufferline#go(8)
nmap <leader>9 <Plug>lightline#bufferline#go(9)

" Terminal
nnoremap <leader>t :terminal<CR>

nnoremap Q @q

" Paragraph jumping
nnoremap J }j
nnoremap K {k

inoremap jj <ESC>

" Easy window navigation (leader + hjkl)
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

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
  " Use guifont only for GUI Vim
  set guifont=Ubuntu\ Mono\ Nerd\ Font:h12
endif

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch
" Clear search highlight with <leader>/
nnoremap <leader>/ :nohlsearch<CR>

command! -bang -nargs=* Find
	 \ call fzf#vim#grep(
	 \		'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
	 \		<bang>0
	 \			? fzf#vim#with_preview('up:60%')
	 \			: fzf#vim#with_preview('right:50%:hidden', '?'),
	 \		<bang>0
	 \ )

autocmd ColorScheme * highlight IncSearch guibg=green

command! FindWordUnderCursor execute 'Find ' . expand('<cword>')

command! FilesUnderCursor execute 'Files ' . expand('<cword>')

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   fzf#vim#with_preview({
  \     'source': 'rg --files --hidden --follow --glob "!.git/*"',
  \     'options': ['--preview', 'bat --color=always {}']
  \   }),
  \   <bang>0)

" Fern
let g:fern#default_hidden=1
let g:fern#renderer = 'nerdfont'

nnoremap <leader>r :Fern . -drawer -toggle -reveal=%<CR>

" Fern file operation commands
command! FernDelete call feedkeys("\<Plug>(fern-action-trash)")
command! FernMove call feedkeys("\<Plug>(fern-action-move)")
command! FernCopy call feedkeys("\<Plug>(fern-action-copy)")
command! FernRename call feedkeys("\<Plug>(fern-action-rename)")
command! FernNewFile call feedkeys("\<Plug>(fern-action-new-file)")
command! FernNewDir call feedkeys("\<Plug>(fern-action-new-dir)")

function! s:init_fern() abort
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
  nmap <buffer> D <Plug>(fern-action-trash)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
endfunction

augroup fern-custom
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

" Ripgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m

" fzf"

nnoremap <leader>c :Commands<CR>
nnoremap <leader>y :History:<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>P :FilesUnderCursor<CR>
nnoremap <leader>f :Find 
nnoremap <leader>F :FindWordUnderCursor<CR>

" MassReplace accross project
function! MassReplace(pattern, replacement)
 let l:command = "rg ". a:pattern. " -l | xargs sed -i '' -e 's/". a:pattern. "/". a:replacement. "/g'"
 call system(l:command)
 execute "bufdo edit"
 echom l:command
endfunction

command! -nargs=+ MassReplace call MassReplace(<f-args>)

" fzf
let g:fzf_commands_expect = 'alt-enter'

" vim-qfreplace - search and replace workflow
" RgQf - Search and populate quickfix list (for use with Qfreplace)
command! -nargs=+ RgQf call setqflist([]) | execute 'silent grep! <args>' | copen
" Quick mapping to open qfreplace after a search
nnoremap <leader>R :Qfreplace<CR>

" Python - using uv
command! PythonRun execute '!clear; uv run "%"'
autocmd FileType python nnoremap <leader>x :PythonRun<CR>

" Python settings
autocmd FileType python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ expandtab
    \ autoindent
    \ fileformat=unix

" Python ALE configuration for uv
let g:ale_python_auto_virtualenv = 1
let g:ale_python_ruff_executable = 'uv'
let g:ale_python_ruff_options = 'run ruff'
let g:ale_python_pyright_executable = 'uv'
let g:ale_python_pyright_options = 'run pyright'

" Go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_code_completion_enabled = 0  " Let ALE handle completion
let g:go_highlight_extra_types = 1

" Go tab settings (use tabs instead of spaces)
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

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

" Splits
set splitright
set splitbelow

