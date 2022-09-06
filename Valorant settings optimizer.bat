@echo off

set py=true
where /q python.exe || (set py=false)
if %py%==true (goto checks) else (goto python)


:checks
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

if EXIST "%LOCALAPPDATA%\ShooterGame\Saved\Config" (
    goto interface
) ELSE (
    goto error2 (
     
    )
)   

Ping www.google.com -n 1 -w 1200 > null

if errorlevel 1 goto error else goto interface

setlocal EnableDelayedExpansion


:interface
TITLE Optimize Valorant
color 06
echo.
echo.
echo Optimize Valorant game settings  [1]          
echo.
echo.
echo.
set /p chocie="Select the corresponding number: "
if not '%choice%'=='' set choice=%choice:~0,1%
if %chocie% == 1 goto Valorant
ECHO "%choice%" is not valid, try again

:Valorant
powershell Invoke-WebRequest "https://raw.githubusercontent.com/aAshvinth/Valorant-Settings-Optimizer/main/vt.py" -OutFile "%temp%\vt.py"
if errorlevel 1 goto error1
%SystemRoot%\explorer.exe "%LOCALAPPDATA%\ShooterGame\Saved\Config" 
set /p "config= Drag the folder with random numbers and letters to this window and press ENTER >>"
xcopy "%config%\GameUserSettings.ini" "%temp%\GameUserSettings.ini*" /Q > nul
cd %temp%
python vt.py
xcopy "%temp%\GameUserSettings.ini" "%config%\GameUserSettings.ini*" /y /Q > nul
goto end



:end
TITLE Success!
cd %temp%
del "%temp%\vt.py" 
del "%temp%\GameUserSettings.ini" 
msg "%username%" Valorant has been optimized!
exit




:python
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
TITLE Download python 3
color 06
echo.
echo python 3 not installed
echo.
echo.
echo Want to install python now?
set /p chocie="[y]yes [N]no: "
if %chocie% == y goto pyinstall
if %chocie% == yes goto pyinstall
if %chocie% == n exit
if %chocie% == no exit

:pyinstall
cls
TITLE Downloading Python 3
color 06
powershell Invoke-WebRequest "https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe" -OutFile "%temp%\python-3.10.6-amd64.exe"
cls
TITLE Installing python
echo.
echo This may take a few moments please wait.
cd %temp%
%CD%\python-3.10.6-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
msg %userprofile% Python has been installed (Restart your device and reopen.)
exit


:error
TITLE ERROR!
color 06
echo.
echo ERROR! Make sure you are connected to the internet.
echo.
echo.
echo.
echo.
pause
exit

:error1
cls
TITLE ERROR!
color 06
echo.
echo ERROR! Could not download the required files.
echo.
echo.
echo.
echo.
pause
exit

:error2
cls
TITLE ERROR!
color 06
echo.
echo ERROR! Valorant not detected. Make sure you ran it atleast once.
echo.
echo.
echo.
echo.
pause
exit

