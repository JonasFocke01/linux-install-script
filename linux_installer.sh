#!/bin/bash

echo "INSTALL HELPER FOR LINUX"
echo

echo "Update System now (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt update -y
	sudo apt upgrade -y
fi

echo "Install KeepassXC? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install keepassxc -y
	scp -P 88 -r manfild@tigerly:/volume1/Allgemeine\\\ Daten/Familie/Jonas/Geschäftlich/KeePassXC_ Desktop
 	sudo apt install cifs-utils -y
	echo "The keepass database is on the desktop"
fi

echo "Install Firefox? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install firefox -y
fi

echo "create new ssh key? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	ssh-keygen -f /home/jonas/.ssh/id_rsa -N ''
	sudo apt install xclip -y
	echo "Go to the Github login page and log in. The URL is in your clipboard"
	echo "https://github.com/login" | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	echo "Now go to the settings and ssh keys. The URL is in your clipboard"
	echo "https://github.com/settings/keys" | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	echo "The new ssh key is now in your clipboard, just create a new one on the site."
	cat .ssh/id_rsa.pub | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	cat .ssh/id_rsa.pub | xclip -sel clip
	echo "Now we gonna connect to tigerly"
	echo "The **ONLY** thing you have to do now, after typing in the password, is to 'CRTL+(SHIFT)+V' and then 'CTRL+C'k"
	echo "Tee is started and therefore you DO NOT NEED TO DO ANYTHING ELSE"
	echo "This will paste the generated ssh key into the authorized_keys file"
	echo "And therefore allow this computer from now on to connect to tigerly without a password"
	ssh manfild@tigerly -p 88 -t "cd .ssh; tee authorized_keys; bash --login"
fi

echo "Install rust? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
fi

echo "Install zsh? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install zsh -y
	chsh -s /usr/bin/zsh 
	# Install oh my zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# Install exa for a ls replacement
	cargo install exa
	sudo apt install fzf
	scp -P 88 manfild@tigerly:/volume1/Allgemeine\\\ Daten/Familie/Jonas/IT/repos/shell_commands/history.md Desktop 
	cat Desktop/history.md | tee .zsh_history
	git clone git@github.com:JonasFocke01/zsh-config.git Desktop/zsh-config
	cat Desktop/zsh-config/.zshrc | tee .zshrc
fi

echo "Install i3? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install i3 -y
	git clone git@github.com:JonasFocke01/i3-config.git .config/i3
	sudo apt install picom -y
	git clone ssh://manfild@tigerly:88/volume1/Allgemeine\ Daten/Familie/Jonas/IT/repos/config_files/picom .config/picom
	sudo apt install i3blocks -y
	git clone git@github.com:JonasFocke01/i3blocks-config.git .config/i3blocks
 	sudo apt install nitrogen -y
  	nitrogen .config/i3/wallpaper --set-auto --random
    	(crontab -l ; echo "## sets a random wallpaper (this might need adjustment. You might set the DISPLAY=:1 varibable to the output from 'env | grep DISPLAY')
        30 * * * * export DISPLAY=:1 && /usr/bin/nitrogen --set-auto --random /home/jonas/.config/i3/wallpaper") | crontab -

fi

echo "Install nvim? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt update -y
	sudo apt install neovim -y
	git clone git@github.com:JonasFocke01/neovim-config.git .config/nvim
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	echo "Please start nvim, go into the file 'packer.lua' and run ':PackerSync'"
fi

echo "Install MonoCraft font? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	wget https://github.com/IdreesInc/Monocraft/releases/download/v3.0/Monocraft-nerd-fonts-patched.ttf
	mkdir .local/share/fonts
	mv Monocraft-nerd-fonts-patched.ttf .local/share/fonts
 	echo "Please go to your terminal, go to preferences and switch the font to MonoCraft Nerd Font. You can also disable scrollbars and the menubar itself in there"
fi

echo "Install Steam? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install steam -y
fi

echo "Install Flameshot? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install flameshot -y
fi

echo "Install Pavucontrol? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install pavucontrol -y
fi

echo "Install node with nvm? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
	nvm install 16.16
fi

echo "Perform cleanup? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo rm -r Desktop Documents Music Pictures Videos Public Templates .bash_history .bash_logout .bashrc .shell.pre-oh-my-zsh
 	mkdir repos workspace
fi

echo "Restart the system now? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo shutdown -r now
fi

