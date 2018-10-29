if &compatible
  set nocompatible
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
call plug#end()

syntax on
colorscheme delek
