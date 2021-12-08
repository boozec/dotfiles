#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9]?%')
CHECK_CHARGING=$(acpi -b | grep -E -o 'Charging')

# Full and short texts
echo "Battery: $BAT"
echo "BAT: $BAT"

if [ "$CHECK_CHARGING" != "" ]; then
    echo "#1abc9c"
    exit 0
fi
# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 5 ] && exit 33
[ ${BAT%?} -le 35 ] && echo "#d35400"

exit 0
