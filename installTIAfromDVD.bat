@echo off

REM Start installation of TIA Portal from DVD drive
set "DVDPath=E:\Start.exe"
set "LogFile=%~dp0install_log.txt"

echo === TIA Portal Installation Log === > "%LogFile%"
echo Timestamp: %DATE% %TIME% >> "%LogFile%"
echo Checking for installer at: %DVDPath% >> "%LogFile%"

REM Check if Start.exe exists in the DVD drive
if exist "%DVDPath%" (
    echo Starting TIA Portal installation...
    echo Installer found. Starting installation... >> "%LogFile%"
    
    "%DVDPath%" /qb REBOOT=Auto INSTALLLANGUAGE=1031;1033 INSTALLDIR="C:\Program Files\Siemens\Automation" INSTALLLEVEL=Typical
    
    echo Installation completed.
    echo Return code: %ERRORLEVEL%
    echo Installation completed. Return code: %ERRORLEVEL% >> "%LogFile%"
) else (
    echo Error: [ %DVDPath% ]: Start.exe not found in DVD drive.
    echo ERROR: Start.exe not found at %DVDPath% >> "%LogFile%"
)

echo Log written to: %LogFile%
pause
