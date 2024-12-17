## Prerequisites
1. Install `Nerd Fonts` executing below script
```sh
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
```
2. create symbolic links to `init.vim` and `lua` folder 

```sh
ln -s $PWD/init.vim $HOME/.config/nvim/init.vim 
ln -s $PWD/lua $HOME/.config/nvim/lua
```
