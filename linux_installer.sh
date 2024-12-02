#!/bin/bash

echo "INSTALL HELPER FOR LINUX"
echo

cd $HOME

echo "Update System now (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt update -y
	sudo apt upgrade -y
 	name=$(whoami)
	git config --global user.name $name
 	distro=$(cat /etc/lsb-release | head -n1)
	git config --global user.email "${name}@${distro}.com"
 	sudo apt install libudev-dev
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
 	cargo install cargo-watch
  	cargo install cargo-deb
    	cargo install elf2uf2-rs
      	cargo install rustup target add thumbv6m-none-eabi
	cargo install probe-rs
fi

echo "Install zsh? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install zsh -y
	chsh -s /usr/bin/zsh
	# Install oh my zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# Install exa to replace ls
	cargo install exa
	sudo apt install fzf
	scp -P 88 manfild@tigerly:/volume1/Allgemeine\\\ Daten/Familie/Jonas/IT/repos/shell_commands/history.md Desktop
	cat Desktop/history.md | tee .zsh_history
 	sudo apt install tlp -y
	git clone git@github.com:JonasFocke01/zsh-config.git Desktop/zsh-config
 	windowsBoot=$(sudo efibootmgr -v | grep Windows | grep -o '000[0-9]')
	sed "s/0002/$windowsBoot/g" Desktop/zsh-config/.zshrc > Desktop/zsh-config/tmp
	mv Desktop/zsh-config/tmp .zshrc
fi

echo "Install gdb with gf2 frontend? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install gdb -y
	mkdir .gf2
 	cd .gf2
 	git clone https://github.com/nakst/gf.git .
  	./build.sh
   	cd ..
    	prev=$(cat .zshrc)
    	echo -n "$prev:/home/jonas/.gf2" >> .zshrc
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
        sudo apt install fzf fd-find ulauncher
	sudo rm -r .config/ulauncher
        mkdir .config/ulauncher
        git clone https://github.com/JonasFocke01/ulauncher-config .config/ulauncher
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
	# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 	# ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	sudo apt install ripgrep
	# echo "Please start nvim, go into the file 'packer.lua' and run ':PackerSync'"
fi

echo "Install MonoCraft font? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	wget https://github.com/IdreesInc/Monocraft/releases/download/v3.0/Monocraft-nerd-fonts-patched.ttf
	mkdir .local/share/fonts
	mv Monocraft-nerd-fonts-patched.ttf .local/share/fonts
 	echo "Please go to your terminal, go to preferences and switch the font to MonoCraft Nerd Font. You can also disable scrollbars and the menubar itself in there"
fi

echo "Install Remindy? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install moreutils -y
	mkdir repos
	git clone git@github.com:JonasFocke01/remindy.git repos/remindy
	cd repos/remindy
	./linux_install_script.sh
 	echo "Warning, this migh involve more configuration"
  	sleep 5s
	cd ../..
fi

echo "Install solar-overview? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir repos
	git clone git@github.com:JonasFocke01/solar-overview.git repos/solar-overview
	cd repos/solar-overview
	./linux_install_script.sh
	cd ../..
fi

echo "Install btc_miner_deamon? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir repos
	git clone git@github.com:JonasFocke01/btc_miner_deamon.git repos/btc_miner_deamon
	cd repos/btc_miner_deamon
	cargo build -r
	cd ../..
 	prev=$(cat .zshrc)
    	echo -n "$prev:/home/jonas/repos/btc_miner_deamon/target/release/" >> .zshrc
fi

echo "Install Gaming suite? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install steam -y
 	sudo apt install discord -y
fi

echo "Automount tigerly? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    echo "//tigerly/Allgemeine\040Daten /mnt/tigerly cifs username=manfild,password=DSsiKul24Sd,vers=2.0 0 0" | sudo tee -a /etc/fstab
fi

echo "Install Flameshot? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install flameshot -y
 	sudo apt install feh -y
fi

echo "Install Pavucontrol? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install pavucontrol -y
fi

echo "Install nvm? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
fi

echo "Install spotify? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
 	sudo apt update
	sudo apt install spotify -y
fi

echo "Install Vlc Player? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install vlc -y
fi

echo "Automount proton at startup? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir proton
	crontab -l > mycron
 	echo "* * * * * rclone mount proton: proton --vfs-cache-mode writes" >> mycron
  	crontab mycron
 	rm mycron
fi

echo "Perform cleanup? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo rm -r Desktop Documents Music Pictures Videos Public Templates .bash_history .bash_logout .bashrc .shell.pre-oh-my-zsh
 	mkdir repos workspace
fi

echo "Configure Systemd config? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo tee /etc/systemd/logind.conf <<EOF
[Login]
HandlePowerKey=suspend
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=yes
EOF
fi

echo "Install arduino-cli? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    cd Desktop
    wget https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz
    mkdir ../.arduino-cli
    tar -xzf arduino-cli_latest_Linux_64bit.tar.gz -C ../.arduino-cli
    cd ..
    sed -i -e "\$s/\$/:\/home\/$(whoami)\/.arduino-cli/" .zshrc
fi

echo "Restart the system now? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo shutdown -r now
fi

