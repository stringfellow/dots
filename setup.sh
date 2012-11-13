#!/bin/bash
rm -rf ~/.vim
cp -r .vim ~/.vim
cp .vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

cp .tmux.conf ~/.tmux.conf
cp spike.zsh ~/.oh-my-zsh/custom/spike.zsh
