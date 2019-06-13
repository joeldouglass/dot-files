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
cp -a ./.oh-my-zsh $HOME/.oh-my-zsh/

# Install vimplug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugs
vim +PlugInstall +qall

echo "done!" > $HOME/.setupdone
