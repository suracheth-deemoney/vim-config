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
