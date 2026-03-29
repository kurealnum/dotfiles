mkdir transcoded; for i in *.{mp4,mov,mkv}; do ffmpeg -n -hwaccel cuda -i "$i" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "transcoded/${i%.*}.mov"; done
