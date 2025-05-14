#!/bin/bash
set -euo pipefail

# apply hdparm HDD spindown to only HDD drives on the system
# apply this at boot with crontab;
# @reboot /path/to/hdparm-hdd-spindown.sh

# docs:
# https://wiki.archlinux.org/title/Hdparm
# https://www.man7.org/linux/man-pages/man8/hdparm.8.html

# NOTE:
# check if a drive is active or in standby;
# sudo smartctl -i -n standby /dev/sda
#
# get drive info
# sudo hdparm -I /dev/sda

# 241 = 30min
SPINDOWN_VALUE=241

# Loop through all /dev/sd? devices
for dev in /dev/sd?; do
    # Check if device is rotational (HDD) and not SSD or NVMe
    if [[ -f "/sys/block/$(basename $dev)/queue/rotational" ]]; then
        rotational=$(cat /sys/block/$(basename $dev)/queue/rotational)
        if [[ "$rotational" == "1" ]]; then
            # echo "Setting spindown for $dev to $SPINDOWN_VALUE (30 minutes)"
            hdparm -S "$SPINDOWN_VALUE" "$dev"
        else
            :
        fi
    fi
done