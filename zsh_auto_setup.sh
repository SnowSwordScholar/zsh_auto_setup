#! /bin/sh

# Copyright (c) 2024 SnowSwordScholar (https://github.com/SnowSwordScholar/zsh_auto_setup)
# 
# 此项目将帮助您安装 Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh) 和 zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
# This project will help you to install Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh) and zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions).
# Both of these projects are available under the MIT License.
#
# The list of contributors for Oh My Zsh can be found at https://github.com/ohmyzsh/ohmyzsh/contributors.
#
# This project will also help you to install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting),
# which is available under a license similar to the BSD-3-Clause License. Please refer to the relevant documentation for specific terms.

usage() {
    echo "用法 | Usage: $0 [选项 | options]"
    echo "选项 | Options:"
    echo "  -p, --proxy [地址 | address]   设置HTTP/HTTPS代理 | Set HTTP/HTTPS proxy"
    echo "  -n, --no-proxy                跳过代理设置 | Skip proxy setup"
    echo "  -h, --help                    显示帮助信息 | Show help"
    exit 0
}

echo_cyan() {
  printf '\033[1;36m%s\033[0m\n' "$@"
}

echo_red() {
  printf '\033[1;31m%s\033[0m\n' "$@"
}

# 参数解析 | Parameter parsing
proxy_setup="ask"
while [ $# -gt 0 ]; do
    case "$1" in
        -p|--proxy)
            if [ -z "$2" ]; then
                echo_red "错误：代理地址不能为空 | Error: Proxy address cannot be empty"
                exit 1
            fi
            proxy_address="$2"
            proxy_setup="yes"
            shift 2
            ;;
        -n|--no-proxy)
            proxy_setup="no"
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo_red "未知参数 | Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# 代理设置 | Proxy setup
if [ "$proxy_setup" = "ask" ]; then
    echo_cyan "是否需要设置HTTP/HTTPS代理？(y/N) | Do you need to set up HTTP/HTTPS proxy? (y/N):"
    read need_proxy
    need_proxy=$(echo "$need_proxy" | tr '[:upper:]' '[:lower:]')
    [ "$need_proxy" = "y" ] && proxy_setup="yes"
fi

if [ "$proxy_setup" = "yes" ]; then
    if [ -z "$proxy_address" ]; then
        echo_cyan "请输入代理地址（例如http://proxy.example.com:8080）| Please enter proxy address (e.g. http://proxy.example.com:8080):"
        read proxy_address
    fi
    
    export http_proxy="$proxy_address"
    export https_proxy="$proxy_address"
    echo_cyan "已设置代理为 | Proxy set to: $proxy_address"
fi

# 安装zsh | Install ZSH
echo_cyan "安装zsh | Install ZSH"
if ! sudo apt install zsh curl git -y; then
    echo_red "安装软件包失败，请检查网络或权限 | Package installation failed, check network or permissions"
    exit 1
fi

# 下载安装脚本 | Download install script
echo_cyan "下载 Oh My ZSH 脚本并让他不急"
echo_cyan "  | Download the Oh My ZSH script and don't let it worry."
if ! curl -fsSL -o omy_zsh_install.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh; then
    echo_red "下载失败，请检查网络或代理设置 | Download failed, check network or proxy"
    exit 1
fi

# 修改安装脚本 | Modify install script
if ! sed -i '/exec zsh -l/d' omy_zsh_install.sh; then
    echo_red "修改安装脚本失败 | Failed to modify install script"
    rm omy_zsh_install.sh
    exit 1
fi

if ! chmod +x omy_zsh_install.sh; then
    echo_red "修改脚本权限失败 | Failed to change script permissions"
    rm omy_zsh_install.sh
    exit 1
fi

# 安装Oh My ZSH | Install Oh My ZSH
echo_cyan "安装 Oh My ZSH | Installing Oh My ZSH"
if ! sh omy_zsh_install.sh; then
    echo_red "安装失败 | Installation failed"
    rm omy_zsh_install.sh
    exit 1
fi
rm -f omy_zsh_install.sh

# 安装插件 | Install plugins
echo_cyan "安装插件 | Installing plugins"
clone_error=0
target_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions "$target_dir/zsh-autosuggestions" || clone_error=1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$target_dir/zsh-syntax-highlighting" || clone_error=1

if [ $clone_error -ne 0 ]; then
    echo_red "插件安装失败，请检查网络连接 | Plugin installation failed, check network connection"
    exit 1
fi

# 修改配置文件 | Modify configuration
echo_cyan "更新配置文件 | Updating configuration"
if ! sed -i 's/plugins=(git)/plugins=(git\n     zsh-autosuggestions\n     zsh-syntax-highlighting\n     z\n)/g' ~/.zshrc; then
    echo_red "配置文件更新失败 | Failed to update configuration"
    exit 1
fi

# 完成安装 | Finish installation
echo_cyan "Enjoy it !"
zsh -c 'source ~/.zshrc'
exec zsh -l