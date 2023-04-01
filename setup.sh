#!/bin/bash

# Define script dir
src_dir=$(dirname "$0")

termux_setup ()
{
echo "[*] Updating termux...."
apt update
echo " "
echo "[*] Upgrading termux...."
apt upgrade
echo " "
echo "[*] Installing packages...."
apt install neovim zsh git curl clang cmake nodejs fzf stylua tmux fd ripgrep
echo " "
}

linux_setup ()
{
echo "[*] Updating packages...."
sudo apt update
echo " "
echo "[*] Upgrading packages...."
sudo apt upgrade
echo " "
echo "[*] Installing packages...."
sudo apt install neovim zsh git curl clang cmake nodejs fzf stylua tmux fd ripgrep
echo " "
}

zsh () {
echo "[*] Installing OhMyZsh...."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo " "
echo "[*] Installing Powerlevel10k...."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo " "
echo "[*] Installing zsh plugins...."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ~/.zshrc
cp $src_dir/.zshrc ~/
}

# Installation process
clear
echo "Welcome to Termux setup script!"
echo " "
read -p "Are you using
[1] Termux
[2] Linux
: " user_choice

if [[ $user_choice=1 ]]; then
  termux_setup
elif [[ $user_choice=2 ]]; then
  linux_setup
else
  echo "Choose a valid choice...." 
fi

rm -rf ~/.config/nvim
mkdir ~/.config
cp -r $src_dir/.config/nvim ~/.config/

read -p "Do you want to install zsh? (y for yes): " user_choice

if [[ $user_choice == "y" ]]; then
  zsh
else
  echo "Zsh wasn't installed"
fi
# Replace configuration files
rm -rf ~/.tmux.conf
cp $src_dir/.tmux.conf ~/.tmux.conf
rm -rf ~/.tmux
cp -r $src_dir/.tmux ~/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

nvim +PackerSync

echo "Thanks
Don't forget to run 'source ~/.zshrc' and read README.md to understand!"
