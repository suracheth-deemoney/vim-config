" Enable mouse support
set mouse=a
" Show absolute line numbers
set number
" Show relative line numbers from cursor position
set relativenumber
" Disable text wrapping
set nowrap
" Enable sign column for marks
set signcolumn=yes

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
" Wayland clipboard support
Plug 'jasonccox/vim-wayland-clipboard'

" Rust language support - enhanced syntax highlighting, rustfmt integration, and Rust-specific commands
Plug 'rust-lang/rust.vim'
" Elixir language support - syntax highlighting, filetype detection, and indentation for all Elixir file types
Plug 'elixir-editors/vim-elixir'
" Elixir mix format integration - asynchronous formatting on save
Plug 'mhinz/vim-mix-format'
" Markdown language support - syntax highlighting, folding, and markdown-specific commands
Plug 'plasticboy/vim-markdown'
" Git gutter - shows git changes in the sign column
Plug 'airblade/vim-gitgutter'
" Git integration - fugitive for git commands inside vim
Plug 'tpope/vim-fugitive'
" Git integration - gitv for git log viewer
Plug 'gregsexton/gitv'
" Comment plugin - toggle comments with gcc/gc
Plug 'tpope/vim-commentary'
" Fuzzy finder with ripgrep integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Dracula theme - dark theme for Vim
Plug 'dracula/vim', { 'as': 'dracula' }
 " Coc autocompletion plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Airline status line - enhanced status bar with many features
Plug 'vim-airline/vim-airline'
" Airline themes collection
Plug 'vim-airline/vim-airline-themes'
" Show marks in sign column
Plug 'kshenoy/vim-signature'
call plug#end()

" Coc global extensions
let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-elixir',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-yaml'
  \ ]

" Fern configuration
" Show hidden files by default in fern
let g:fern#default_hidden=1

 " Key bindings for fern
 " Toggle fern file explorer drawer with leader+t
 nnoremap <leader>t :Fern . -drawer -toggle<cr>

 " Coc key mappings
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

 inoremap <silent><expr> <c-space> coc#refresh()

  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)

 nmap <silent> <leader>gd <Plug>(coc-definition)
 nmap <silent> <leader>gy <Plug>(coc-type-definition)
 nmap <silent> <leader>gi <Plug>(coc-implementation)
 nmap <silent> <leader>gr :call CocReferencesQuickfix()<CR>
 nmap <leader>rn <Plug>(coc-rename)

 xmap <leader>a  <Plug>(coc-codeaction-selected)
 nmap <leader>a  <Plug>(coc-codeaction)

 nmap <silent> <leader>K :call <SID>show_documentation()<CR>

 function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
     execute 'h '.expand('<cword>')
   elseif (coc#rpc#ready())
     call CocActionAsync('doHover')
   else
     execute '!' . &keywordprg . " " . expand('<cword>')
   endif
 endfunction

 function! CocReferencesQuickfix()
   let refs = CocAction('references')
   if !empty(refs)
     let qf = []
     for ref in refs
       let filename = substitute(ref.uri, '^file://', '', '')
       let lnum = ref.range.start.line + 1
       let col = ref.range.start.character + 1
       let text = ''
       if filereadable(filename)
         let lines = readfile(filename, '', lnum)
         if len(lines) >= lnum
           let text = lines[lnum - 1]
         endif
       endif
       call add(qf, {'filename': filename, 'lnum': lnum, 'col': col, 'text': text})
     endfor
     call setqflist(qf)
     copen
   endif
 endfunction

 autocmd CursorHold * silent call CocActionAsync('highlight')



















" Auto-formatting configuration for Rust
" Enable automatic rustfmt on save for Rust files
let g:rustfmt_autosave = 1

" Auto-formatting configuration for Elixir
" Enable automatic mix format on save for Elixir files
let g:mix_format_on_save = 1

" TypeScript/JavaScript specific configurations
" Enable auto-formatting for TypeScript/JavaScript files
autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal formatexpr=CocAction('formatSelected')
autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal omnifunc=v:lua.vim.lsp.omnifunc

" TypeScript/JavaScript key mappings
" Format current file with prettier
nnoremap <leader>pf :CocCommand prettier.formatFile<CR>
" Format selected range with prettier
xmap <leader>pf <Plug>(coc-format-selected)
nmap <leader>pf <Plug>(coc-format-selected)
" Organize imports in TypeScript/JavaScript
nnoremap <leader>oi :CocCommand tsserver.organizeImports<CR>
" Restart TypeScript server
nnoremap <leader>trs :CocCommand tsserver.restart<CR>
" Toggle ESLint auto-fix
nnoremap <leader>ef :CocCommand eslint.toggleAutoFixOnSave<CR>



" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" File type specific settings
" JavaScript/TypeScript settings
autocmd FileType javascript,javascriptreact,typescript,typescriptreact 
  \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  \ | setlocal commentstring=//%s

" JSON settings
autocmd FileType json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" HTML/CSS settings
autocmd FileType html,css,scss,less 
  \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Theme configuration
" Enable true color support
if has('termguicolors')
    set termguicolors
endif

" Apply the dracula theme
colorscheme dracula

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

" Git integration configuration
" Enable fugitive commands
let g:fugitive_git_executable = 'git'
" Open git status in vertical split
command! Gstatus vertical Git status
" Show git commit in vertical split
command! Gcommit vertical Git commit

" FZF fuzzy finder key mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>rg :Rg<Space>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>h :History<CR>

" Comment key mappings
" Toggle comment for current line
nnoremap <leader>cc :Commentary<CR>
" Toggle comment for visual selection
xnoremap <leader>cc :Commentary<CR>
" Git integration key mappings
nnoremap <leader>gs :Git<CR>                " Open git status
nnoremap <leader>gc :Git commit<CR>         " Git commit
nnoremap <leader>gca :Git commit --amend<CR> " Git commit amend
nnoremap <leader>gp :Git push<CR>           " Git push
nnoremap <leader>gpl :Git pull<CR>          " Git pull
nnoremap <leader>ga :Git add %<CR>          " Git add current file
nnoremap <leader>gaa :Git add .<CR>         " Git add all files
 nnoremap <leader>gdf :Git diff<CR>           " Git diff
nnoremap <leader>gds :Git diff --staged<CR> " Git diff staged
nnoremap <leader>gb :Git blame<CR>          " Git blame
nnoremap <leader>gl :Git log<CR>            " Git log
nnoremap <leader>gv :Gitv<CR>               " Git log viewer
nnoremap <leader>gsh :Git stash<CR>         " Git stash
nnoremap <leader>gsp :Git stash pop<CR>     " Git stash pop
 nnoremap <leader>grm :Git remove %<CR>       " Git remove current file

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
 let g:airline_theme = 'dracula'
 " Show airline in all windows
 let g:airline_statusline_ontop = 0
 " Enable gitgutter integration with airline
 let g:airline#extensions#gitgutter#enabled = 1
  " Enable coc integration with airline
  let g:airline#extensions#coc#enabled = 1

" Custom visual selection highlight
hi Visual guibg=#bd93f9 guifg=#282a36 ctermbg=magenta ctermfg=black








