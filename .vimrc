set nocompatible

" Set leader early
let g:mapleader = ' '
let g:maplocalleader = ' '

filetype plugin on
filetype indent on

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'tmsvg/pear-tree'
Plug 'dense-analysis/ale'
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
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
set pastetoggle=€
set cursorline
set colorcolumn=80
set signcolumn=yes
set grepprg=rg\ --vimgrep
set autoread
set rtp+=/usr/local/opt/fzf
set ttimeout
set timeoutlen=1000 ttimeoutlen=0

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
" Prevent mouse click from entering select mode
set selectmode=
" Fix Ghostty focus event escape codes
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"

" Cursor shape
let &t_SI = "\e[6 q"  " Insert mode: vertical line
let &t_SR = "\e[4 q"  " Replace mode: underline
let &t_EI = "\e[2 q"  " Normal mode: block

" Remove automatic insertion of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Autoreload files
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
     \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Return to normal mode when focusing vim (fixes mouse click issue)
autocmd FocusGained * if mode() == 'v' || mode() == 'V' || mode() == "\<C-v>" | execute "normal! \<Esc>" | endif

" Lightline
let g:lightline = {
     \      'colorscheme': 'sonokai',
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
     \          'filename': 'LightlineFilename',
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
let g:ale_linters = {
\   'python': ['pyright', 'ruff', 'flake8']
\}
let g:ale_fixers = {
\   'python': ['black', 'isort', 'ruff']
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_black_options = '--line-length 88'
let g:ale_python_isort_options = '--profile black'
" Enable LSP features
let g:ale_lsp_suggestions = 1
let g:ale_hover_cursor = 0

" ALE LSP Navigation
" Go to definition with Enter (like cmd-click but better!)
nnoremap <CR> :ALEGoToDefinition<CR>
" Go back with Shift-Enter
nnoremap <S-CR> <C-o>
" Go to definition (alternative)
nnoremap gd :ALEGoToDefinition<CR>
" Go to references
nnoremap gD :ALEFindReferences<CR>
" Show documentation
nnoremap K :ALEHover<CR>
" Fix it (auto-fix with ALE)
nnoremap <leader>x :ALEFix<CR>
" Navigate between errors/warnings
nnoremap <leader>e :ALENextWrap<CR>
nnoremap <leader>E :ALEPreviousWrap<CR>

" Python-specific: enhanced gf to handle Python imports
autocmd FileType python setlocal path+=**
autocmd FileType python setlocal suffixesadd=.py
autocmd FileType python setlocal includeexpr=substitute(v:fname,'\\.','/','g')

" Maps

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Open terminal in bottom drawer for executing bash commands
nnoremap <leader>t :terminal<CR>

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

nnoremap o o<ESC>
nnoremap O O<ESC>

nnoremap <M-j> }j
nnoremap <M-k> {k

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

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch

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
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>y :History:<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>P :FilesUnderCursor<CR>
nnoremap <leader>f :Find
nnoremap <leader>F :FindWordUnderCursor<CR>

" Fern
noremap <leader>r :Fern . -reveal=% -drawer<CR>
let g:fern#default_hidden=1
let g:fern#renderer = 'nerdfont'

" Fern actions (use these in the Fern drawer)
command! FernDelete execute "normal \<Plug>(fern-action-remove)"
command! FernRename execute "normal \<Plug>(fern-action-rename)"
command! FernCopy execute "normal \<Plug>(fern-action-copy)"
command! FernMove execute "normal \<Plug>(fern-action-move)"
command! FernNewFile execute "normal \<Plug>(fern-action-new-file)"
command! FernNewDir execute "normal \<Plug>(fern-action-new-dir)"

" fzf
let g:fzf_commands_expect = 'alt-enter'

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

