#!/bin/bash
#set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd "$SCRIPTPATH"

./bin/linux/unor4wifi-reboot-linux64
if [ "$?" -ne 0 ]; then
    echo "Cannot put the board in ESP mode. (via 'unor4wifi-reboot')"
    exit 1
fi

echo "Start flashing firmware"
sleep 1
./bin/linux/espflash write-bin -b 115200 0x0 firmware/S3.bin