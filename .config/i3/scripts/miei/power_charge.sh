#!/usr/bin/bash
#echo " 󰣐 󰣐 󰣐 󰣐 󰋔 "
#echo ""
#echo "#a6e3a1"
#  󰁹󱐋

level=$( upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | grep -o "[0-9]*")

unit=20
vite=$(($level/unit))

if [ $vite == 5 ]; then
	echo "󱐋 "
	echo ""
	echo "#cdd6f4"
fi

if [ $vite == 4 ]; then
	echo "󱐋 "
	echo ""
	echo "#a6e3a1"
fi
if [ $vite == 3 ]; then
	echo "󱐋 "
	echo ""
	echo "#a6e3a1"
fi
if [ $vite == 2 ]; then
	echo "󱐋 "
	echo ""
	echo "#fab387"
fi
if [ $vite == 1 ]; then
	echo "󱐋 "
	echo ""
	echo "#fab387"
fi
if [ "$level" -lt "20" ] && [ "$level" -ge "10" ]; then
	echo "󱐋 "
	echo ""
	echo "#f38ba8"
fi
if [ "$level" -lt "10" ]; then
	echo "󱐋 !"
	echo ""
	echo "#f38ba8"
fi
