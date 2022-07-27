#!/bin/sh

isLow(){
	b=$(($(cat /sys/class/power_supply/BAT0/capacity) >= 20)) # >= is correct, because if passes, when function exits with non-zero code.
	return $b
}
while xsetroot -name "`setxkbmap -query | grep --color=none -oE \"us\\|ee\"` | `cat /sys/class/power_supply/BAT0/capacity` | `date \"+%a %F %R\"`"
do 
	if isLow; then notify-send --urgency=critical "Battery low"; fi
	sleep 60
done
