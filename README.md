# Quickstart

Run this in your terminal to use the latest script:
```bash
curl -O https://raw.githubusercontent.com/JonasFocke01/linux-install-script/refs/heads/main/linux_installer.sh && chmod +x linux_installer.sh && ./linux_installer.sh && rm linux_installer.sh
```

# linux-install-script

This is my PERSONAL install script for the most common software i use like nvim, i3 and so on...
For two or three steps it tries to connect to my local nas, but is is written to continue on fail, so with no nas, the steps are simply scripped, so that it can be used in many circumstances. This also pulls some private repos from my github with configurations. So no guarantees, that all steps work for you.

This asks before each step if you want to perform it.
`install spotify (y/n)`...

## Reasoning

I created this little script, because even for common tasks like installing nvim, there are many things you have to do, and i cant remember them all. I reinstall my system often, because im tinkering around and swap distros. This script just install what i would manually install.

## Disclaimer

This is currently only testet for popos 22.04, but most of the steps should work on all debian or even on all linux based systems
