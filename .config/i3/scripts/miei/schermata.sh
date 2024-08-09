#!/usr/bin/bash
a=$(date +"%Y-%m-%d-%T")-schermata.png

maim --select ~/Immagini/Schermate/$a
notify-send "Screenshot saved to ~/$a"
#kdialog --yesno "Screenshot salvato, vuoi aprirlo?"
#if [ $? == 0 ]; then
  eog ~/Immagini/Schermate/$a
#fi

