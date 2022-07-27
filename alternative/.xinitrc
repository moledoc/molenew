export max_brightness=$(cat /sys/class/backlight/*/max_brightness)
export brightness_step=$(echo $(($max_brightness/20)))
export sound_step=5%
export LESS="-R"
export PATH="$PATH:/usr/sbin"

setxkbmap -option caps:swapescape

amixer set 'Master' on
amixer set 'Master' 30%

.scripts/dwmbar.sh &
sxhkd &
pulseaudio --start &
dunst & # notification receiver
exec dwm
