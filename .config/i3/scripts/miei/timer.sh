#!/usr/bin/bash
#creazione meccanismo di cambiamento timer modalità m (modifica)
path=/tmp/miotimer

modifica () {
if [ $BLOCK_BUTTON == 4 ];then
	current=$((current + 1))
	echo $mode > $path
	echo $current >> $path
fi
if [ $BLOCK_BUTTON == 5 ] && [ $current != 0 ];then
	current=$((current - 1))
	echo $mode > $path
	echo $current >> $path
fi
if [ $current == 0 ];then
       echo "󰔛 Tmr"
else
echo " $(sed '2!d' $path) m"
echo ""
echo "#f9e2af"
fi       
}

timer () {
start=$(sed '2!d' $path)
start=$((start * 60))
now=$(date +%s)
first=$(sed '3!d' $path)
manca=$((start-now+first))
if [ $manca != 0 ];then
	echo "󰄉 $((manca / 60)):$((manca % 60))"
	echo ""
	echo "#a6e3a1"

else
	echo "󰔛 Tmr"
	notify-send "Timer is over"
	rm $path
fi
}




if [ -f $path ]
then


	mode=$(sed '1!d' $path)
	current=$(sed '2!d' $path)

	if [ $BLOCK_BUTTON == 1 ] && [ $current != 0 ];then
	if [ $mode == "w" ];then
	rm $path	
	echo "󰔛 Tmr" 	
	exit	
	fi	
	mode=w	
	echo $mode > $path
	echo $current >> $path
	echo $(date +%s) >> $path		
	fi


	if [ $mode == "m" ];then
	modifica
	fi

	if [ $mode == "w" ];then
	timer	
	fi



else
echo m > $path 
echo 0 >> $path 
echo "󰔛 Tmr" 
fi
