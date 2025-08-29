
@echo off

REM Start installation of TIA Portal from DVD drive

set "DVDPath=E:\Start.exe"

REM Check if Start.exe exists in the DVD drive
if exist "%DVDPath%" (
    echo Starting TIA Portal installation...
    "%DVDPath%" /qb REBOOT=Auto INSTALLLANGUAGE=1031;1033 INSTALLDIR="C:\Program Files\Siemens\Automation" INSTALLLEVEL=Typical
    echo Installation completed.
    echo Return code: %ERRORLEVEL%
) else (
    echo Error: [ %DVDPath% ]: Start.exe not found in DVD drive.
)

pause
