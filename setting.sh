#!/bin/bash

git config --global user.name "Hansu Kim"
git config --global user.email "cpm0722@gmail.com"
git config --global core.editor vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ~/.vim/colors
cp jellybeans.vim  ~/.vim/colors/jellybeans.vim
vim -c 'PluginInstall' -c 'qa!'
