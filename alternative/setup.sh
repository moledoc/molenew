#!/bin/sh

user=$(whoami)
# Script to make alternative setup
su -c "apt update -y && apt upgrade -y; apt install -y xorg libx11-dev lbxft-dev libxinerama-dev clang git make wget curl sxhkd doas alsa-utils dunst pulseaudio
echo \"
permit nopass $user
permit nopass $user cmd /usr/bin/tee args /sys/class/backlight/*/brightness
\" > /etc/doas.conf"
# doas ^

# disable root password
doas -- sed -i 's/root:x:0:0:root:\/root:\/bin\/bash/root:x:0:0:root:\/root:\/sbin\/nologin/g' /etc/passwd

# suckless
# TODO: 1) make and apply own patches 2) keep modified builds in my repo
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu

cd dwm;   doas -- make clean install; cd ..
cd st;    doas -- make clean install; cd ..
cd dmenu; doas -- make clean install; cd ..

# google-chrome
wget --show-progress "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
export PATH="$PATH:/usr/sbin"
doas -- apt-get -f install
# doas -- dpkg -i google-chrome-stable_current_amd64.deb
rm -f https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# keyboard default option
doas -- sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:swapescape"/g' /etc/default/keyboard

# set doas back to permit for user
doas -- sed -i "0,/nopass/permit" /etc/doas.conf


# mkdirs
mkdir -p .config/sxhkd
mkdir -p .scripts

# link files
# ln -s ".vimrc" "/home/$user/.vimrc"
# ln -s ".bashrc" "/home/$user/.bashrc"
ln -s ".config" "/home/$user/.config"
ln -s ".scripts" "/home/$user/.scripts"

does -- systemctl reboot

