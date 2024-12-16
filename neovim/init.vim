set number
lua << EOF
require("config.lazy")
require("lualine").setup({options = {theme = 'tokyonight'}})
require("Comment").setup()
EOF

colorscheme tokyonight

" Set Leader key
let mapleader = ","

" File files using telescope command-line sugar
nnoremap <leader>ff <cmd> Telescope find_files<cr>
nnoremap <leader>fg <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope buffers<cr>
nnoremap <leader>fh <cmd> Telescope help_tags<cr>

