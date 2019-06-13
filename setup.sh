#!/bin/bash

# Check for previous setup
{
if [ -f $HOME/.setupdone ]; then
    echo "Setup was already run!"
    exit 0
fi
}

# Copy from checkout folder
cp -a ./ $HOME/

# Install and setup zsh
sudo apt-get install zsh
chsh -s $(which zsh)

# Remove this for now
rm -r $HOME/.oh-my-zsh

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Copy oh my zsh configs back in
cp $HOME/dot-files/.oh-my-zsh/themes/joel.zsh-theme $HOME/.oh-my-zsh/themes

# Install vimplug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugs
vim +PlugInstall +qall

rm -rf $HOME/dot-files

echo "done!" > $HOME/.setupdone
