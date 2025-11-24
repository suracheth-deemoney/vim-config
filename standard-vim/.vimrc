" Show absolute line numbers
set number
" Show relative line numbers from cursor position
set relativenumber

" Set Leader key to match neovim configuration
let mapleader = ","

" vim-plug plugin manager
call plug#begin()
" Add plugins here
" File explorer plugin - fern for file navigation
Plug 'lambdalisue/vim-fern'
call plug#end()

" Fern configuration
" Show hidden files by default in fern
let g:fern#default_hidden=1

" Key bindings for fern
" Toggle fern file explorer drawer with leader+t
nnoremap <leader>t :Fern . -drawer -toggle<cr>
