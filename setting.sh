#!/bin/bash

if [[ -e ~/.bashrc ]]; then
    cat .bashrc >> ~/.bashrc
else
    cp .bashrc ~/.bashrc
fi

git config --global user.name "Hansu Kim"
git config --global user.email "cpm0722@gmail.com"
git config --global core.editor vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./.vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp jellybeans.vim  ~/.vim/colors/jellybeans.vim
vim -c 'PluginInstall' -c 'qa!'
