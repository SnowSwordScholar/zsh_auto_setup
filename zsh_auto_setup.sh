#! /bin/sh
# Copyright (c) 2024 SnowSwordScholar (https://github.com/SnowSwordScholar/zsh_auto_setup)
# 
# This project will help you to install Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh) and zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions).
# Both of these projects are available under the MIT License.
#
# The list of contributors for Oh My Zsh can be found at https://github.com/ohmyzsh/ohmyzsh/contributors.
#
# This project will also help you to install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting),
# which is available under a license similar to the BSD-3-Clause License. Please refer to the relevant documentation for specific terms.
echo_cyan() {
  printf '\033[1;36m%s\033[0m\n' "$@"
}

echo_cyan "安装zsh | Install ZSH"
sudo apt install zsh curl git -y


echo_cyan "下载 Oh My ZSH 脚本并让他不急"
echo_cyan "  | Download the Oh My ZSH script and don't let it worry."
curl -fsSL -o omy_zsh_install.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sed -i '/exec zsh -l/d' omy_zsh_install.sh
chmod +x omy_zsh_install.sh

echo_cyan "安装 Oh My ZSH | Install Oh My ZSH"
sh omy_zsh_install.sh
# . ./omy_zsh_install.sh


echo_cyan "安装插件 | Setup Plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(git\n     zsh-autosuggestions\n     zsh-syntax-highlighting\n     z\n)/g' ~/.zshrc

echo_cyan "Enjoy it !"
zsh -c 'source ~/.zshrc'
exec zsh -l
