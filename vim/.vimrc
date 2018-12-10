if &compatible
  set nocompatible
endif

call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'evidens/vim-twig'
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'rakr/vim-one'
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'w0rp/ale'
  Plug 'romainl/Apprentice'
call plug#end()

set backspace=indent,eol,start
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set expandtab
set hidden
set incsearch
set nobackup
set nowrap
set nowritebackup
set number
set ruler
set showcmd
set softtabstop=2 shiftwidth=2 expandtab
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list

runtime macros/matchit.vim

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

if has('mouse')
  set mouse=a
endif

augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
    \  if isdirectory(expand('<amatch>'))
    \|   call plug#load('nerdtree')
    \|   execute 'autocmd! nerd_loader'
    \| endif
augroup END

let mapleader = ","
nnoremap <TAB> :bnext<cr>
nnoremap <S-TAB> :bprevious<cr>
nnoremap <S-TAB> :bprevious<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>w :w<cr>
nnoremap <F10> :NERDTreeToggle<cr>

if v:version >= 703
  inoremap <F11> <esc>:TagbarToggle<cr>
  nnoremap <F11> :TagbarToggle<cr>
  let g:tagbar_sort = 0
endif

syntax on
colorscheme apprentice
