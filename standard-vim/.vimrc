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
" LSP support for Vim 8+ - provides Language Server Protocol support
Plug 'prabirshrestha/vim-lsp'
" Rust language support - enhanced syntax highlighting, rustfmt integration, and Rust-specific commands
Plug 'rust-lang/rust.vim'
" Gruvbox Material theme - modern take on gruvbox with light and dark variants
Plug 'sainnhe/gruvbox-material'
call plug#end()

" Fern configuration
" Show hidden files by default in fern
let g:fern#default_hidden=1

" Key bindings for fern
" Toggle fern file explorer drawer with leader+t
nnoremap <leader>t :Fern . -drawer -toggle<cr>

" LSP configuration for rust-analyzer
" Checks if rust-analyzer is executable before registering the server
if executable('rust-analyzer')
    " Register rust-analyzer as LSP server for Rust files
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
endif

" LSP key mappings - using leader key (,) for consistency
nnoremap <leader>gd :LspDefinition<CR>      " Go to definition
nnoremap <leader>gr :LspReferences<CR>      " Show references
nnoremap <leader>gi :LspImplementation<CR>  " Go to implementation
nnoremap <leader>K :LspHover<CR>            " Show hover documentation
nnoremap <leader>rn :LspRename<CR>          " Rename symbol
nnoremap <leader>ca :LspCodeAction<CR>      " Show code actions

" Auto-formatting configuration for Rust
" Enable automatic rustfmt on save for Rust files
let g:rustfmt_autosave = 1

" Theme configuration
" Enable true color support
if has('termguicolors')
    set termguicolors
endif

" Set gruvbox-material theme with light background
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'material'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_transparent_background = 0

" Apply the theme
colorscheme gruvbox-material
