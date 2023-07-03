@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
setlocal

CALL bin\windows\unor4wifi-reboot

IF %ERRORLEVEL% NEQ 0 (
    GOTO ESPMODEERROR
)

echo Start flashing firmware
CALL bin\windows\espflash write-bin -b 115200 0x0 firmware\S3.bin

@pause
exit /b 0

:ESPMODEERROR
echo Cannot put the board in ESP mode. (via 'unor4wifi-reboot')
@pause
exit /b 1