set number
set wrap!
" Set Leader key
let mapleader = ","
lua << EOF
require("config.lazy")
require("Comment").setup()
require("nvim-treesitter.configs").setup({highlight = {enable = true}, indent = {enable = true, auto_install = true}})
require("lualine").setup({options = {icons_enabled = true, theme = 'tokyonight'}})
EOF

colorscheme tokyonight


" File files using telescope command-line sugar
nnoremap <leader>ff <cmd> Telescope find_files<cr>
nnoremap <leader>fg <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope buffers<cr>
nnoremap <leader>fh <cmd> Telescope help_tags<cr>

" Fern config
nnoremap <leader>t <cmd> Fern .<cr>

