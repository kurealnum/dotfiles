#!/usr/bin/bash

if [ $BLOCK_BUTTON -eq "1" ];then
	kitty -e sudo dnf upgrade  
	kitty -e flatpak update
fi


numero=$(dnf check-update| grep -Ec ' updates$')
if [ $numero -eq "0" ];then
echo " "
else
echo "󰏕 $numero"
echo ""
echo "#f9e2af"
fi
