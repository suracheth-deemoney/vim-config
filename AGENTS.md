# AGENTS.md - Vim/Neovim Configuration Repository

## Build/Lint/Test Commands
This is a configuration repository with no traditional build/test commands. 
- Setup: Create symbolic links as documented in README files
- Neovim: `ln -s $PWD/init.vim $HOME/.config/nvim/init.vim && ln -s $PWD/lua $HOME/.config/nvim/lua`
- Standard Vim: Install vim-plug and run `:PlugInstall`

## Code Style Guidelines

### File Organization
- `neovim/` - Neovim configuration with init.vim and lua/ subdirectory
- `standard-vim/` - Traditional Vim configuration with .vimrc
- `lua/config/` - Lua configuration modules for Neovim

### Vim Script Conventions
- Use 2-space indentation for JavaScript/TypeScript files (autocmd rules in init.vim:143-147)
- Leader key set to comma (`,`)
- Use `nnoremap` for normal mode mappings, avoid recursive mappings
- Group autocmds with `augroup`/`au!`/`augroup END` pattern

### Lua Conventions (Neovim)
- Use `require()` for module imports
- Plugin specs in lazy.lua follow lazy.nvim format
- LSP configurations use `lspconfig` with coq integration
- Use `vim.keymap.set()` for key mappings in Lua

### Plugin Management
- Neovim: lazy.nvim (bootstrapped in lua/config/lazy.lua)
- Standard Vim: vim-plug (plugins listed in .vimrc)

### Language-Specific Settings
- Elixir: elixir-ls with dialyzer enabled, mix format
- JavaScript/TypeScript: 2-space indentation, expandtab
- Terraform/Rust/HTML/Lua: LSP configured via lspconfig