# setxkbmap -option caps:swapescape # not needed, see setup script
amixer set 'Master' on
amixer set 'Master' 30%

.scripts/dwmbar.sh &
sxhkd &
pulseaudio --start &
dunst & # notification receiver
exec dwm
