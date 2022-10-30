# My Dot Config

This is my backup dot config file for several config like i3, neovim, bash, qutebrowser, powershell, vagrant etc. 


Windows Terminal Powershell using startship. 

1. https://starship.rs/ 

2. scoop install windows-terminal

3. [Profile] (https://raw.githubusercontent.com/hardyweb/myDotConfig/main/%24profile%20power%20shell )

4. scoop install neovim-nightly



Linux Terminal

1. Bash 

2. Zsh 

3. Fish 

4. Qutebrowser [config] (https://raw.githubusercontent.com/hardyweb/myDotConfig/main/config.py) 



Window Tiling Manager 

1. i3 

2. apt-get install -y suckless-tools



Neovim 

apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen -y

    git clone https://github.com/neovim/neovim
    cd neovim && make
	make install
	cd ..
	rm -rf neovim



wget -o  ~/.config/nvim/init.lua https://raw.githubusercontent.com/hardyweb/myDotConfig/main/init.lua

nvim --headless +PackerInstall +qa





