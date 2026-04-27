#!/bin/bash

if ! command -v bluetoothctl >/dev/null 2>&1; then
    echo "No blue"
    exit 0
fi

STATUS=$(bluetoothctl show | grep "Powered: yes" | wc -l)

if [ "$STATUS" -eq 0 ]; then
    echo "󰂲 Off"
    echo "󰂲 Off"
    echo "#a89984"
else
    DEVICE=$(bluetoothctl info | grep "Name:" | cut -d' ' -f2-)
    if [ -z "$DEVICE" ]; then
        echo "󰂯 On"
        echo "󰂯 On"
    else
        echo "󰂱 $DEVICE"
        echo "󰂱 $DEVICE"
    fi
fi
