#!/usr/bin/bash
if [ "$BLOCK_BUTTON" == 1 ]; then
	kitty -e htop
fi

IDLE=$(vmstat 1 2 | tail -1 | awk '{print $15}')
USAGE=$((100 - IDLE))

echo "$USAGE%"

