@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
setlocal

echo Finding UNO R4 WiFi...
for /f "tokens=1" %%i in ('bin\windows\arduino-cli board list ^| findstr "unor4wifi" ^| findstr "COM"') do (
    set COM_PORT=%%i
)

IF %COM_PORT% == "" (
    GOTO NOTCONNECTED
)

:FLASHARDUINO

echo Finding UNO R4 WiFi OK at %COM_PORT%
CALL bin\windows\unor4wifi-reboot

IF %ERRORLEVEL% NEQ 0 (
    GOTO ESPMODEERROR
)

echo Start flashing firmware
CALL \bin\windows\espflash write-bin -p %COM_PORT% -b 115200 0x0 firmware\S3.bin

@pause
exit /b 0

:NOTCONNECTED
echo Cannot find a connected UNO R4 WiFi development board via 'arduino-cli board list'
@pause
exit /b 1

:ESPMODEERROR
echo Cannot put the board in ESP mode. (via 'unor4wifi-reboot')
@pause
exit /b 1