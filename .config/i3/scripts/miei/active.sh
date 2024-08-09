#!/usr/bin/bash
if [ -f /tmp/tray ]; then
	var=$(cat /tmp/tray)
	if [ $var == 1 ]; then
	echo 0 > /tmp/tray
	i3-msg -q "bar mode dock bar-tray"
	i3-msg -q "bar mode invisible bar-primary"	
	fi
   
	if [ $var == 0 ]; then
	echo 1 > /tmp/tray
	i3-msg -q "bar mode invisible bar-tray"
	i3-msg -q "bar mode dock bar-primary"	
	
	fi 
else
	echo 0 > /tmp/tray
	i3-msg -q "bar mode dock bar-tray"
	i3-msg -q "bar mode invisible bar-primary"	
fi
