#!/usr/bin/bash                                                                                         
file=/tmp/powerprofile                                                                                  
                                                                                                        
if ! test -f $file; then                                                                                
echo 0 > $file                                                                                          
powerprofilesctl set power-saver                                                                        
fi                                                                                                      
                                                                                                        
a=$(cat $file)                                                                                          
                                                                                                        
if [ $BLOCK_BUTTON == 1 ]                                                                               
then                                                                                                    
if [ $a == 0 ]                                                                                          
then                                                                                                    
echo 1 > $file                                                                                          
echo "  Blc"                                                                                           
powerprofilesctl set balanced                                                                           
fi                                                                                                      
                                                                                                        
if [ $a == 1 ]                                                                                          
then                                                                                                    
echo 2 > $file                                                                                          
echo "  Pro"                                                                                           
powerprofilesctl set performance                                                                        
fi                                                                                                      
                                                                                                        
if [ $a == 2 ]                                                                                          
then                                                                                                    
echo 0 > $file                                                                                          
echo "  Eco"                                                                                           
powerprofilesctl set power-saver                                                                        
fi                                                                                                      
fi                                                                                                      
                                                                                                        
if [ $a == 1 ]; then                                                                                    
echo "  Blc"                                                                                           
fi                                                                                                      
                                                                                                        
if [ $a == 0 ]; then                                                                                    
echo "  Eco"                                                                                           
fi                                                                                                      
                                                                                                        
if [ $a == 2 ]; then                                                                                    
echo "  Pro"                                                                                           
fi  
