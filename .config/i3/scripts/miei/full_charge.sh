#!/usr/bin/bash

# quando lo clicco mi ricarica il dispositivo fino al 100% e poi disabilita la feature
path="/sys/devices/pci0000:00/0000:00:14.3/PNP0C09:00/VPC2004:00/conservation_mode"
value=$(cat $path)
if [ $value -eq "" ];then
	echo "only ideapad"
fi

level=$( upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | grep -o "[0-9]*")

if [ $BLOCK_BUTTON -eq 1 ] && [ $value -eq "1" ];then
	echo "󱟡 full"
	echo $PASSW | sudo -S sh -c "echo 0 > $path"
fi


if [ $level -ge "95" ] && [ $value -eq "0" ];then
	echo "󱈑 Csv"
	echo $PASSW | sudo -S sh -c "echo 1 > $path"
fi

if [ $value -eq 0 ];then
	echo "󱟡 full"
else
	echo "󱈑 Csv"
fi


