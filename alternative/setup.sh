#!/bin/sh
set -e

user=$(whoami)

# Script to make alternative setup
su -c "apt update -y && apt upgrade -y; apt install -y xorg libx11-dev libxft-dev libxinerama-dev clang git make wget curl sxhkd doas alsa-utils dunst pulseaudio libedit-dev autotools-dev automake fzf tmux universal-ctags chromium xclip xsel
echo \"permit nopass $user
permit nopass $user cmd /usr/bin/tee args /sys/class/backlight/*/brightness
\" > /etc/doas.conf"

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

# dash with extended functionality
git clone https://git.kernel.org/pub/scm/utils/dash/dash.git
cd dash ;./autogen.sh ;./configure --with-libedit ;make;doas -- cp src/dash /bin/dash-extended;cd ..
echo "/bin/dash-extended -iV" | doas tee /bin/dash-login
doas -- chmod +x /bin/dash-login
echo "/bin/dash-login" | doas -- tee -a /etc/shells
chsh -s /bin/dash-login

## google-chrome
#wget --show-progress "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
#export PATH="$PATH:/usr/sbin"
#doas -- dpkg -i google-chrome-stable_current_amd64.deb # TODO: fails here, add package to install
#doas -- apt-get -f install
#rm -f https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# keyboard default option
test -d /etc/default || doas -- mkdir -v /etc/default
test -f /etc/default/keyboard || doas -- touch /etc/default/keyboard
doas -- sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:swapescape"/g' /etc/default/keyboard

# set doas back to permit for user
doas -- sed -i '1,1s/nopass/persist' /etc/doas.conf

# clean files before linking
rm -fr "$HOME/.config" "$HOME/.scripts"
rm -f "$HOME/.xinitrc" "$HOME/.profile"

# link files
# ln -s ".vimrc" "/home/$user/.vimrc"
# ln -s ".bashrc" "/home/$user/.bashrc"
ln -s "$HOME/.config"  "$HOME/.config"
ln -s "$HOME/.scripts" "$HOME/.scripts"
ln -s "$HOME/.xinitrc" "$HOME/.xinitrc"
ln -s "$HOME/.profile" "$HOME/.profile"

doas -- systemctl reboot
