# ZSH Auto Setup
ZSH 一键安装脚本，将在 `Debian` / `Ubuntu` 系统上自动安装 ZSH 、 Oh My Zsh ，并配置插件： git zsh-autosuggestions zsh-syntax-highlighting z    
  
One-click installation script for ZSH, which automatically installs ZSH, Oh My Zsh on `Debian` / `Ubuntu` systems, and configures plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, z.
## 使用方式 | Usage Method
### 使用 curl
`sh <(curl -s -S -L https://raw.githubusercontent.com/SnowSwordScholar/zsh_auto_setup/main/zsh_auto_setup.sh)`  
### 使用 wget
`sh <(wget -qO-  https://raw.githubusercontent.com/SnowSwordScholar/zsh_auto_setup/main/zsh_auto_setup.sh)`

### 命令行参数：
`sh <(wget -qO-  https://raw.githubusercontent.com/SnowSwordScholar/zsh_auto_setup/main/zsh_auto_setup.sh) --proxy http://your.proxy:8080`
```
# 交互式安装
./zsh_auto_setup.sh

# 直接设置代理
./zsh_auto_setup.sh --proxy http://proxy.example.com:8080

# 跳过代理设置
./zsh_auto_setup.sh --no-proxy

# 显示帮助
./zsh_auto_setup.sh --help
```
  
  
![图片](https://github.com/SnowSwordScholar/zsh_auto_setup/assets/73566969/a2f6950f-086e-486e-8bd4-69add871591a)

# 声明 | Declaration
这个项目将帮助您安装 Oh My Zsh（https://github.com/ohmyzsh/ohmyzsh）和 zsh-autosuggestions（https://github.com/zsh-users/zsh-autosuggestions）。
这两个项目都在 MIT 许可证下可用。

Oh My Zsh 的贡献者名单可以在 https://github.com/ohmyzsh/ohmyzsh/contributors 找到。

该项目还将帮助您安装 zsh-syntax-highlighting（https://github.com/zsh-users/zsh-syntax-highlighting），
它在类似 BSD-3-Clause 许可证下可用。具体条款请参阅相关文档。
  
  
    
This project will help you to install Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh)  and zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions). 
Both of these projects are available under the MIT License.

The list of contributors for Oh My Zsh can be found at https://github.com/ohmyzsh/ohmyzsh/contributors. 

This project will also help you to install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting), 
which is available under a license similar to the BSD-3-Clause License. Please refer to the relevant documentation for specific terms.
