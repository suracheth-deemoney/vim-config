" Show absolute line numbers
set number
" Show relative line numbers from cursor position
set relativenumber
" Disable text wrapping
set nowrap

" Use spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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
" Elixir language support - syntax highlighting, filetype detection, and indentation for all Elixir file types
Plug 'elixir-editors/vim-elixir'
" Git gutter - shows git changes in the sign column
Plug 'airblade/vim-gitgutter'
" Fuzzy finder with ripgrep integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Gruvbox Material theme - modern take on gruvbox with light and dark variants
Plug 'sainnhe/gruvbox-material'
" Async completion framework for Vim 8+
Plug 'prabirshrestha/asyncomplete.vim'
" LSP integration for asyncomplete
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Airline status line - enhanced status bar with many features
Plug 'vim-airline/vim-airline'
" Airline themes collection
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Fern configuration
" Show hidden files by default in fern
let g:fern#default_hidden=1

" Key bindings for fern
" Toggle fern file explorer drawer with leader+t
nnoremap <leader>t :Fern . -drawer -toggle<cr>

" Function to get general LSP status for all servers
function! GetLSPStatus()
    let l:running_count = 0
    let l:starting_count = 0
    let l:total_count = 0
    
    " Check rust-analyzer
    if executable('rust-analyzer')
        let l:total_count += 1
        try
            let l:rust_status = lsp#get_server_status('rust-analyzer')
            if l:rust_status ==# 'running'
                let l:running_count += 1
            elseif l:rust_status ==# 'starting'
                let l:starting_count += 1
            endif
        catch
        endtry
    endif
    
    " Check elixir-ls
    if executable('elixir-ls')
        let l:total_count += 1
        try
            let l:elixir_status = lsp#get_server_status('elixir-ls')
            if l:elixir_status ==# 'running'
                let l:running_count += 1
            elseif l:elixir_status ==# 'starting'
                let l:starting_count += 1
            endif
        catch
        endtry
    endif
    
    if l:total_count == 0
        return 'LSP: ✗'
    elseif l:running_count > 0
        return 'LSP: ✓ (' . l:running_count . '/' . l:total_count . ')'
    elseif l:starting_count > 0
        return 'LSP: ... (' . l:starting_count . '/' . l:total_count . ')'
    else
        return 'LSP: ✗'
    endif
endfunction

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

" LSP configuration for elixir-ls
" Checks if elixir-ls is executable before registering the server
if executable('elixir-ls')
    " Register elixir-ls as LSP server for Elixir files and templates
    au User lsp_setup call lsp#register_server({
        \ 'name': 'elixir-ls',
        \ 'cmd': {server_info->['elixir-ls']},
        \ 'whitelist': ['elixir', 'eelixir'],
        \ })
endif

" Enable asyncomplete with LSP integration
augroup asyncomplete_lsp
    autocmd!
    autocmd User lsp_setup call asyncomplete#register_source(asyncomplete#sources#lsp#get_source_options({
        \ 'name': 'lsp',
        \ 'whitelist': ['rust', 'elixir', 'eelixir'],
        \ 'completor': function('asyncomplete#sources#lsp#completor')
        \ }))
augroup END

" LSP key mappings - using leader key (,) for consistency
nnoremap <leader>gd :LspDefinition<CR>      " Go to definition
nnoremap <leader>gr :LspReferences<CR>      " Show references
nnoremap <leader>gi :LspImplementation<CR>  " Go to implementation
nnoremap <leader>K :LspHover<CR>            " Show hover documentation
nnoremap <leader>rn :LspRename<CR>          " Rename symbol
nnoremap <leader>ca :LspCodeAction<CR>      " Show code actions





" LSP log and debugging commands
nnoremap <leader>ll :tabnew ~/.vim/lsp.log<CR> " Show LSP logs in new tab
nnoremap <leader>lt :let g:lsp_debug = !g:lsp_debug<Bar>echo "LSP debug: " . (g:lsp_debug ? "ON" : "OFF")<CR> " Toggle LSP debugging
nnoremap <leader>ls :echo lsp#get_server_info('elixir-ls')<CR> " Show elixir-ls info
nnoremap <leader>lS :echo lsp#get_server_info('rust-analyzer')<CR> " Show rust-analyzer info

" Manual autocomplete trigger
inoremap <C-space> <C-x><C-u>

" Auto-formatting configuration for Rust
" Enable automatic rustfmt on save for Rust files
let g:rustfmt_autosave = 1



" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

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

" Git gutter configuration
" Enable git gutter by default
let g:gitgutter_enabled = 1
" Show signs in the sign column
let g:gitgutter_signs = 1
" Enable line highlights
let g:gitgutter_highlight_lines = 1
" Update signs on focus gained and buffer enter
let g:gitgutter_async = 1
" Start immediately without delay
let g:gitgutter_realtime = 1
" Set up signs for better visibility
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▎'
let g:gitgutter_sign_modified_removed = '▎'

" Ensure git gutter starts immediately
autocmd VimEnter * GitGutterAll
autocmd BufEnter * GitGutter

" FZF fuzzy finder key mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>rg :Rg<Space>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>h :History<CR>

" FZF configuration
" Use ripgrep for file searching if available
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info --prompt=""'
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
endif



" Airline configuration
" Enable airline status line
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox_material'
" Show airline in all windows
let g:airline_statusline_ontop = 0
" Enable gitgutter integration with airline
let g:airline#extensions#gitgutter#enabled = 1

" LSP progress messages
" Show LSP progress in command line
let g:lsp_show_message = 1
let g:lsp_show_message_format = '%d: %s'

" Enable LSP progress reporting for airline
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 500

" LSP logging configuration
let g:lsp_log_level = 'info'
let g:lsp_log_file = expand('~/.vim/lsp.log')
let g:lsp_debug = 1

" Custom function to display LSP status for airline
function! AirlineLSPStatus()
    return GetLSPStatus()
endfunction

" Custom function to display LSP progress for airline
function! AirlineLSPProgress()
    if exists('g:lsp_progress') && !empty(g:lsp_progress)
        return g:lsp_progress
    endif
    return ''
endfunction

" Add LSP status and progress to airline sections
let g:airline_section_x = airline#section#create(['%{AirlineLSPStatus()}'])
let g:airline_section_y = airline#section#create(['%{AirlineLSPProgress()}'])

" Update LSP status and airline when LSP state changes
augroup airline_lsp
    autocmd!
    autocmd User lsp_server_initialized call airline#update_statusline()
    autocmd User lsp_server_exit call airline#update_statusline()
    autocmd User lsp_diagnostics_updated call airline#update_statusline()
    autocmd FileType * call airline#update_statusline()
    autocmd BufEnter * call airline#update_statusline()
    autocmd CursorHold,CursorHoldI call airline#update_statusline()
augroup END
