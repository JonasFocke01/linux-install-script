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
	echo "The **ONLY** thing you have to do now, after typing in the password, is to 'CRTL+(SHIFT)+V' and then 'CTRL+C'"
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

echo "Install shell? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install zsh fzf alacritty -y
	cargo install exa
	chsh -s /usr/bin/zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
fi

echo "Add shortcut to reboot into windows? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
        echo "Warning: This does not work correctly, so this step is skipped."
	echo "Please refer to the install script to manually do this."
 	echo "TODO: Fix this step."
	# windowsBoot=$(sudo efibootmgr -v | grep Windows | grep -o '000[0-9]')
	# sed "s/0002/$windowsBoot/g" Desktop/zsh-config/.zshrc > Desktop/zsh-config/tmp
	# mv Desktop/zsh-config/tmp .zshrc
fi

echo "Install utils? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install tlp -y
fi

echo "Install i3? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install i3 -y
        sudo apt install i3blocks -y
        sudo apt install fzf fd-find ulauncher -y
	sudo apt install feh -y
fi

echo "Install nvim? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt update -y
	sudo apt install neovim -y
	sudo apt install ripgrep
fi

echo "Clone WIP projects? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir repos
 	cd repos
 	git clone git@github.com:JonasFocke01/ruhige_waldgeraeusche.git
  	git clone git@github.com:JonasFocke01/remindy.git
   	cd ..
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
 	echo "TODO: rclone needs to be installed and configured"
 	echo "* * * * * rclone mount proton: proton --vfs-cache-mode writes" >> mycron
  	crontab mycron
 	rm mycron
fi

echo "Perform cleanup? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo rm -r Documents Music Pictures Videos Public Templates .bash_history .bash_logout .bashrc
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

echo "Use my dotfiles? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    sudo apt install stow -y
    git clone git@github.com:JonasFocke01/dotfiles.git
    cd dotfiles
    stow --adopt .
    git restore .
    cd $HOME
fi

echo "Restart the system now? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo shutdown -r now
fi

