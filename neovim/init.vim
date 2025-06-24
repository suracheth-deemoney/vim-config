set nowrap
set number
" Search with Case Insensitive
set ignorecase
" Set Leader key
let mapleader = ","
let g:coq_settings = { 'auto_start': v:true }
lua << EOF
require("config.lazy")
EOF

colorscheme vague
lua << EOF
require("Comment").setup()
require("nvim-treesitter.configs").setup({
    highlight = {enable = true},
    indent = {enable = true },
    auto_install = true,
    matchup = {
	    enable = true
    }
})

-- LSP Setup
-- Configure Telescope
require('telescope').setup({pickers = {
    find_files = {
      hidden = true,
      respect_gitignore = false,
      file_ignore_patterns = {
       "^.git/",
       "node_modules/.*"
      }
    }
  }})
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

-- Enhanced Elixir LSP Configuration
require("lspconfig").elixirls.setup(coq.lsp_ensure_capabilities({
  cmd = { "elixir-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      -- Enable dialyzer for better type checking
      dialyzerEnabled = true,
      -- Enable fetching deps when source changes
      fetchDeps = true,
      -- Enable automatic suggestion of @spec
      suggestSpecs = true,
      -- Enable formatting
      enableTestLenses = true,
      -- Set the formatter (can be "mix_format" or "prettier")
      mixFormatEnabled = true,
      -- -- Set project root patterns
      -- projectDir = ".",
      -- Additional settings for better performance
      incrementalDialyzer = true,
      -- Enable signature help
      signatureAfterComplete = true,
    }
  },
  root_dir = require('lspconfig').util.root_pattern("mix.exs", ".git"),
  -- Add specific filetypes
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  -- Custom initialization options
  init_options = {
    -- Skip dialyzer for faster startup (can be enabled per project)
    skipDialyzer = false,
  },
}))
require("lspconfig").terraformls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").rust_analyzer.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").html.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lspconfig").custom_elements_ls.setup(coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities}))
require("lualine").setup({ sections = {
    lualine_a = {'mode', {
      'lsp_status',
      icon = '', -- f013
      symbols = {
        -- Standard unicode symbols to cycle through for LSP progress:
        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        -- Standard unicode symbol for when LSP is done:
        done = '✓',
        -- Delimiter inserted between LSP names:
        separator = ' ',
      },
      -- List of LSP names to ignore (e.g., `null-ls`):
      ignore_lsp = {},
    } },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }, options = {icons_enabled = true}})

require("mason-lock").setup({
  lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json" -- (default)
}) 
EOF

" File files using telescope command-line sugar
nnoremap <leader>ff <cmd> Telescope find_files<cr>
nnoremap <leader>fg <cmd> Telescope live_grep<cr>
nnoremap <leader>fb <cmd> Telescope buffers<cr>
nnoremap <leader>fh <cmd> Telescope help_tags<cr>

" Fern config
let g:fern#default_hidden=1
nnoremap <leader>t <cmd> Fern . -drawer -toggle<cr>

" JavaScript indentation settings
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Enable Spellchecks
set spell
set spelllang=en_us
" Highlight bad spelling
hi SpellBad cterm=underline gui=undercurl
