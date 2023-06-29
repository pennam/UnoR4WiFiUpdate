#!/bin/bash
#set -e

has_serial_port() {
    (./bin/linux/arduino-cli board list | grep "unor4wifi" || true) | cut -d ' ' -f1
}
SERIAL_PORT=$(has_serial_port)

if [ -z "$SERIAL_PORT" ]; then
    echo "Cannot find a connected Arduino UNO R4 WiFi (via 'arduino-cli board list')."
    echo "Disconnect and Reconnect your board before trying again."
    exit 1
fi

./bin/linux/unor4wifi-reboot-linux64
if [ "$?" -ne 0 ]; then
    echo "Cannot put the board in ESP mode. (via 'unor4wifi-reboot')"
    exit 1
fi

echo "Start flashing firmware"
sleep 1
./bin/linux/espflash write-bin -p $SERIAL_PORT -b 115200 0x0 firmware/S3.bin