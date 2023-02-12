@echo off
setlocal enabledelayedexpansion

Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

set valorant_location="%LOCALAPPDATA%\VALORANT\Saved"

if not exist "%valorant_location%" (
  echo.
  echo The VALORANT folder was not found at the following path:
  echo.
  echo %valorant_location%
  echo Please make sure that Valorant is installed and try again,Needs to be played atleast once.   
  pause
  exit /b
)

msg %USERNAME% Select the folder in VALORANT\ Saved \Config which has a random id or  the folder called windows.

rem Opens the file browse dialog to select the folder

set "psCommand="(new-object -COM 'Shell.Application').BrowseForFolder(0,'SELECT VALORANT\ Saved \Config AND CHOOSE THE FOLDER WITH RANDOM NUMBERS AND DIGITS\WINDOWS!',0,0x1c).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "config=%%I"


set config_path=%config%\GameUserSettings.ini

if not exist "%config_path%" (
  echo.
  echo The VALORANT folder was not found at the following path:
  echo.
  echo %config_path%
  echo Please make sure that Valorant is installed and try again,Needs to be played atleast once.   
  pause
  exit /b
)

rem Read the file line by line and store the contents in an array
set i=0
for /f "tokens=*" %%a in (%config_path%) do (
  set /A i+=1
  set line[!i!]=%%a
)


set line[8]=bUseVSync=False
set line[20]=FrameRateLimit=0.000000 
set line[30]=bUseHDRDisplayOutput=False
set line[40]=sg.ResolutionQuality=65.000000
set line[41]=sg.ViewDistanceQuality=1
set line[42]=sg.AntiAliasingQuality=0
set line[43]=sg.ShadowQuality=0
set line[44]=sg.PostProcessQuality=0
set line[45]=sg.TextureQuality=1
set line[46]=sg.EffectsQuality=0
set line[47]=sg.FoliageQuality=0
set line[48]=sg.ShadingQuality=0


(
  for /L %%i in (1,1,%i%) do (
    echo !line[%%i]!
  )
) > %config_path%

msg %USERNAME% Settings are applied!