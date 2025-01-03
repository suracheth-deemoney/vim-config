set nowrap
set number
" Set Leader key
let mapleader = ","
let g:coq_settings = { 'auto_start': v:true }
lua << EOF
require("config.lazy")
require("Comment").setup()
require("nvim-treesitter.configs").setup({highlight = {enable = true}, indent = {enable = true, auto_install = true}})
require("lualine").setup({options = {icons_enabled = true, theme = 'tokyonight'}})

-- LSP Setup
local lspconfig = require('lspconfig')

local coq = require('coq')
require("mason").setup()
require("mason-lspconfig").setup()

require('gitsigns').setup()

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require("lsp-format").on_attach(client, bufnr)

    -- Mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
end

-- Configure servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").elixirls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").terraformls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").rust_analyzer.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").html.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").custom_elements_ls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))

EOF

set background=light
colorscheme tokyonight-day


" File files using telescope command-line sugar
nnoremap <leader>ff <cmd> Telescope find_files<cr>
nnoremap <leader>fg <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope buffers<cr>
nnoremap <leader>fh <cmd> Telescope help_tags<cr>

" Fern config
nnoremap <leader>t <cmd> Fern . -drawer -toggle<cr>
