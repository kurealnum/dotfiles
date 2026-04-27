#!/usr/bin/bash
a=$(date +"%Y-%m-%d-%T")-schermata.png

maim --select ~/Immagini/Schermate/$a
notify-send "Screenshot saved to ~/$a"
  eog ~/Immagini/Schermate/$a

