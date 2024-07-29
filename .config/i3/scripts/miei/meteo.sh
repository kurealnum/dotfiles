#!/usr/bin/bash
meteo=$(curl wttr.in/Sedriano?format=1| xargs echo)
first="${meteo%% *}"
if [ "$meteo" == "" ] || [ "$first" == "Unknown" ]; then
	echo "  Off" 

else
	echo $meteo
fi
