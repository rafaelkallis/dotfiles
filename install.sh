#!/bin/sh

echo "profile"
rm "$HOME/.profile"
ln --symbolic .profile "$HOME/.profile"

echo "vim"
rm "$HOME/.vimrc"
ln --symbolic .vimrc "$HOME/.vimrc"
yay --remove vim
yay --sync --noconfirm gvim

echo "tmux"
yay --sync --noconfirm tmux
rm "$HOME/.tmux.conf"
ln --symbolic .tmux.conf "$HOME/.tmux.conf"

echo "docker"
yay --sync --noconfirm docker docker-compose
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

echo "nodejs"
yay --sync --noconfirm nodejs npm

echo "chromium"
yay --sync --noeditmenu --nodiffmenu --nocleanmenu chromium
