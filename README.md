# Quickstart

Run this in your terminal to use the latest script:
```bash
curl -O https://raw.githubusercontent.com/JonasFocke01/linux-install-script/refs/heads/main/linux_installer.sh && chmod +x linux_installer.sh && ./linux_installer.sh && rm linux_installer.sh
```

# linux-install-script

This is intended as a backup of the rougth software setup i use. This does NOT store any dataa, dotfiles or something else, but is purely intended to serve as a script to restore my most-used software and adapt the underlying debian-based distro to my workflow.  
(Although this does not store dotfiles, it loads some from another repo)

This asks before each step if you want to perform it.
`install spotify (y/n)`...  
and is designed to continue if the command fails.

## Reasoning

I created this little script, because even for common tasks like installing nvim, there are many things you have to do, and i cant remember them all. I reinstall my system often, because im tinkering around and swap distros. This script just does, what i would do manually.
