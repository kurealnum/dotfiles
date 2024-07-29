#!/usr/bin/bash
a=0
path=~/.config/i3/scripts/miei/feed.sh

if [ $BLOCK_BUTTON == 1 ]
then                                                                        
if [ $a == 0 ]
then                                                                           
	sed -i '2d' $path                                         
	sed -i '2ia=1' $path                                     
	a=1
else
	sed -i '2d' $path                                        
        sed -i '2ia=0' $path 
	a=0
fi     
fi

if [ $a == 1 ]
then
	echo  "  $(curl https://www.lescienze.it/news/ -s -L | grep -o href.*h2 | head -n 1 | grep -o -P '(?<=">).*(?=</a>)')" 
else
	echo "󰈙 News"
fi

if [ $BLOCK_BUTTON == 3 ]; then
	xdg-open https://www.lescienze.it/news/
fi

