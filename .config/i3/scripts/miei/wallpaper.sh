#!/usr/bin/bash
w_path=~/.config/wallpaper/
c_path=~/.config/wallpaper/current
config=~/.config/
current=$(cat $c_path)

if [ $BLOCK_BUTTON == 1 ];then
new=$((current+1))
if [ $new == 13 ]; then
	new=0
fi
fi

if [ $BLOCK_BUTTON == 3 ];then
new=$((current - 1))
if [ $new == "-1" ]; then
	new=12
fi
fi

rm "${config}sfondo.jpg"
cp "$w_path$new.jpg" $config
mv "$config$new.jpg" "${config}sfondo.jpg"
sed -i '1d' $c_path 
echo $new >> $c_path
feh --bg-fill ~/.config/sfondo.jpg
