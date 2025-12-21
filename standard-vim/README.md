## Setup

### Plugin Management

This configuration uses vim-plug for plugin management.

1. Install vim-plug:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

2. Add your desired plugins between `call plug#begin()` and `call plug#end()` in .vimrc

3. Install plugins by running:

```vim
:PlugInstall
```

### Configuration Files

Create symbolic links for configuration files:

```bash
# Link .vimrc
ln -s $PWD/.vimrc ~/.vimrc

# Link coc-settings.json for coc.nvim configuration
ln -s $PWD/coc-settings.json ~/.vim/coc-settings.json
```

## Language Support

### TypeScript & JavaScript

This configuration includes comprehensive TypeScript and JavaScript development support:

#### Features
- **IntelliSense**: Auto-completion, function signatures, and parameter info
- **Linting**: ESLint integration with auto-fix on save
- **Formatting**: Prettier integration with format-on-save
- **Type Checking**: TypeScript server integration
- **Import Management**: Auto-organize imports and update imports on file move

#### Key Mappings
- `<leader>pf` - Format current file/selection with Prettier
- `<leader>oi` - Organize imports
- `<leader>trs` - Restart TypeScript server
- `<leader>ef` - Toggle ESLint auto-fix
- `<leader>gd` - Go to definition
- `<leader>gy` - Go to type definition
- `<leader>gi` - Go to implementation
- `<leader>gr` - Find references
- `<leader>rn` - Rename symbol
- `<leader>ac` - Code actions
- `<leader>qf` - Quick fix

#### Setup
1. Install Node.js and npm/yarn
2. Set up your project with the provided template:
   ```bash
   # For new projects - copy the template
   cp /path/to/vim-config/standard-vim/package.json.example ./package.json
   
   # Or create a symbolic link to always use the latest template
   ln -s /path/to/vim-config/standard-vim/package.json.example ./package.json
   
   # Install dependencies
   npm install
   ```
3. The coc extensions will be automatically installed:
   - `coc-tsserver` - TypeScript language server
   - `coc-eslint` - ESLint integration
   - `coc-prettier` - Prettier formatting
   - `coc-json` - JSON support
   - `coc-html` - HTML support
   - `coc-css` - CSS support

#### Configuration
The `coc-settings.json` includes optimized TypeScript/JavaScript settings:
- Auto-import suggestions
- Import module specifier preference (relative)
- ESLint auto-fix on save
- Prettier formatting preferences
- Format-on-save for web development file types
