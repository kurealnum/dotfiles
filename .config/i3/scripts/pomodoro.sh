#!/bin/bash
if [ -f /tmp/pomo_timer ];then
	pluto=$(cat /tmp/pomo_timer)

case $BLOCK_BUTTON in
	3)   if [ $pluto -eq "0" ];then
	     echo "1" > /tmp/pomo_timer 
	     pluto=1 
	     else
	     echo "0" > /tmp/pomo_timer 
	     pluto=0 
	     fi	
		
		;;
esac
	
if [ $pluto -eq "0" ];then

work_time=2400
break_time=1200

msg_start=" Pom"
work_prefix=" "
break_prefix="󰅶 "

start_color="#cdd6f4"

break_color="#a6e3a1"
work_color="#f38ba8"

break_command="notify-send -t 2500 'Grab a tea'"
work_command="notify-send -t 2500 'Time to work!'"

pom_path="/tmp/pomodoro"

function display () {
	min=$((s/60))
	sek=$((s%60))
	if [ $min -eq 0 ]
	then
		min=00
	elif [ $min -lt 10 ]
	then
		min=0$min
	fi
	if [ $sek -lt 10 ]
	then
		sek=0$sek
	fi
	case $2 in # richiamo alla seconda variabile, t
		w)
			echo "$work_prefix$min:$sek"
			echo $min:$sek
			echo $work_color
		;;
		b)
			echo "$break_prefix$min:$sek"
			echo $min:$sek
			echo $break_color
		;;
	esac
}

if [ -f "$pom_path" ] && [ "$(wc -l $pom_path | awk '{print $1}')" -eq 2 ]
then
	p=$(sed '1 d' $pom_path) # time 
	t=$(sed '2 d' $pom_path) # mode 
	case $t in
		w) dur=$work_time;;
		b) dur=$break_time;;
	esac 
	now=$(date +%s)
	s=$((dur-now+p)) # sec mancanti basandosi su orologio e istante chiamata questa fzione 
	if [ $s -le 0 ] # if time less than 0 then switch mode
	then
		case $t in
			w)
				echo b > $pom_path
				eval "$break_command"
				paplay $HOME/.config/i3/scripts/bell.wav	
			;;
			b)
				echo w > $pom_path
				eval "$work_command"
				paplay $HOME/.config/i3/scripts/bell_end.wav	
	
			;;
		esac
		echo "$now" >> $pom_path
	fi
	display "$s" "$t"
else
	echo "$msg_start"
	echo "$msg_start"
	echo "$start_color"
fi

case $BLOCK_BUTTON in
	1)
		if [ -f $pom_path ]; then # if file exists then stop reset timer
			rm $pom_path
		else
			echo w > $pom_path # else start timer
			date +%s >> $pom_path
		fi
	;;
esac

fi

if [ $pluto -eq "1" ];then
~/.config/i3/scripts/miei/timer.sh
fi

else
	echo "0" > /tmp/pomo_timer
fi

