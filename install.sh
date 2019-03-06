#!/bin/sh

# setup yay
git clone https://aur.archlinux.com/yay.git yay
cd yay
makepkg --syncdeps --install --noconfirm
cd ..
rm -rf yay

ls --symbolic .vimrc "$HOME/.vimrc"
yay --remove vim
yay --sync --noconfirm gvim

ls --symbolic .zshrc "$HOME/.zshrc"
yay --sync --noconfirm zsh
chsh -s $(which zsh)

yay --sync --noconfirm docker docker-compose
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

yay --sync --noeditmenu --nodiffmenu --nocleanmenu nvm
nvm install --lts
nvm use --lts
npm install --global javascript-typescript-langserver

yay --sync --noconfirm python ipython python-pip python-setuptools
pip install --user python-language-server

yay --sync --noconfirm rustup

yay --sync --noconfirm jdk-openjdk openjdk-doc openjdk-src maven gradle
yay --sync --noeditmenu --nodiffmenu --nocleanmenu jdtls

yay --sync --noconfirm kotlin

yay --sync --noconfirm clang cmake

yay --sync --noconfirm go
yay --sync --noeditmenu --nodiffmenu --nocleanmenu go-langserver

yay --sync --noeditmenu --nodiffmenu --nocleanmenu chromium ttf-monaco

# echo "urxvt*font: xft:Monaco:size=9:antialias=true" >> .Xresources

sudo reboot
