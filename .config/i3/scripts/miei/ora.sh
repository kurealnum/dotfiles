#!/usr/bin/bash
a=1

path=~/.config/i3/scripts/miei/ora.sh

cambia_var () {
if [ $a == 0 ]; then
	sed -i '2d' $path 
	sed -i '2ia=1' $path
	# se non mostri la variabile subito ci sarà il delay di interval
	a=1 
	return 1
fi
if [ $a == 1 ]; then
        sed -i '2d' $path
	sed -i '2ia=0' $path
        a=0
	return 0
fi
}

if [ $BLOCK_BUTTON == 1 ]; then
	cambia_var
fi

if [ $a == 0 ]; then
	date '+%a %d %b %H:%M' 
fi

if [ $a == 1 ]; then
	date '+%H:%M'                                                                              
fi

