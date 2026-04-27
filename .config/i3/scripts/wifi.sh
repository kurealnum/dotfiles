#!/bin/bash

INTERFACE=$(ip route | awk '/default/ { print $5 }' | head -n1)

if [ -z "$INTERFACE" ]; then
    echo "󰤮 Disconnected"
    echo "󰤮 Disconnected"
    echo "#cc241d"
    exit 0
fi

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2 | sed 's/^yes://')

if [ -z "$SSID" ]; then
    if [[ "$INTERFACE" =~ ^e ]]; then
        echo "󰈀 $INTERFACE"
        echo "󰈀 $INTERFACE"
    else
        echo "󰤫 No SSID"
        echo "󰤫 No SSID"
    fi
else
    echo "󰤨 $SSID"
    echo "󰤨 $SSID"
fi
