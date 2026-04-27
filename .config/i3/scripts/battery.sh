#!/bin/bash

BAT=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(acpi -b | awk '{print $3}' | tr -d ',')

if [ -z "$BAT" ]; then
    echo "No Bat"
    exit 0
fi

if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"
else
    if [ "$BAT" -ge 90 ]; then ICON="󰁹";
    elif [ "$BAT" -ge 80 ]; then ICON="󰂂";
    elif [ "$BAT" -ge 70 ]; then ICON="󰂁";
    elif [ "$BAT" -ge 60 ]; then ICON="󰂀";
    elif [ "$BAT" -ge 50 ]; then ICON="󰁿";
    elif [ "$BAT" -ge 40 ]; then ICON="󰁾";
    elif [ "$BAT" -ge 30 ]; then ICON="󰁽";
    elif [ "$BAT" -ge 20 ]; then ICON="󰁼";
    elif [ "$BAT" -ge 10 ]; then ICON="󰁻";
    else ICON="󰁺"; fi
fi

echo "$ICON $BAT%"
echo "$ICON $BAT%"

if [ "$BAT" -le 15 ] && [ "$STATUS" != "Charging" ]; then
    echo "#cc241d"
fi
