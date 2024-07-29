#!/usr/bin/bash
a=0
path=~/.config/i3/scripts/miei/energia.sh  

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

if [ $a == 1 ]; then                                                                                   
                                                                         
echo "  Pro"
powerprofilesctl set balanced 

fi                                                                                                     
                                                                                                       
if [ $a == 0 ]; then                                                                                   
echo "  Eco"                                                                                     
powerprofilesctl set power-saver 
fi                                                                                                     
   
                                                                        
          


