@echo off
setlocal enabledelayedexpansion

cd %SYSTEMDRIVE%\Hone\Resources
if not exist sed.exe (
	curl -g -L -# -o "%SYSTEMDRIVE%\Hone\Resources\libintl3.dll" "https://github.com/auraside/HoneCtrl/raw/main/Files/libintl3.dll"
	curl -g -L -# -o "%SYSTEMDRIVE%\Hone\Resources\regex2.dll" "https://github.com/auraside/HoneCtrl/raw/main/Files/regex2.dll"
	curl -g -L -# -o "%SYSTEMDRIVE%\Hone\Resources\libiconv2.dll" "https://github.com/auraside/HoneCtrl/raw/main/Files/libiconv2.dll"
	curl -g -L -# -o "%SYSTEMDRIVE%\Hone\Resources\sed.exe" "https://github.com/auraside/HoneCtrl/raw/main/Files/sed.exe"
)
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

set "riotlocalmachine=%localappdata%\Valorant\Saved\Config\Windows\riotlocalmachine.ini"
for /f "tokens=2 delims==" %%a in ('findstr /i "LastKnownUser" "%riotlocalmachine%"') do set "username=%%a"
set "path=%localappdata%\Valorant\Saved\Config"
for /d %%d in ("%path%\%username%*") do (
  set "dir_name=%%~nd"
  set "suffix=!dir_name:%username%=!"
  if not "!suffix!"=="!dir_name!" (
  set config=%%d\Windows
  ) 
)
cd %config%
%SYSTEMROOT%\System32\attrib.exe -r "GameUserSettings.ini"
%SYSTEMROOT%\System32\attrib.exe -r "RiotUserSettings.ini"
%SYSTEMDRIVE%\Hone\Resources\sed.exe -i "s/bUseVSync=True/bUseVSync=False/g;s/PreferredFullscreenMode=0/PreferredFullscreenMode=1/g;s/sg.ResolutionQuality=.*/sg.ResolutionQuality=65.000000/;s/sg.ViewDistanceQuality=.*/sg.ViewDistanceQuality=1/;s/sg.AntiAliasingQuality=.*/sg.AntiAliasingQuality=0/;s/sg.ShadowQuality=.*/sg.ShadowQuality=0/;s/sg.PostProcessQuality=.*/sg.PostProcessQuality=0/;s/sg.TextureQuality=.*/sg.TextureQuality=1/;s/sg.EffectsQuality=.*/sg.EffectsQuality=0/;s/sg.FoliageQuality=.*/sg.FoliageQuality=0/;s/sg.ShadingQuality=.*/sg.ShadingQuality=0/" GameUserSettings.ini
%SYSTEMDRIVE%\Hone\Resources\sed.exe -i "s/EAresIntSettingName::ColorBlindMode=.*/EAresIntSettingName::ColorBlindMode=2/g; s/EAresIntSettingName::NvidiaReflexLowLatencySetting=.*/EAresIntSettingName::NvidiaReflexLowLatencySetting=2/g; s/EAresBoolSettingName::LimitFramerateOnBattery=.*/EAresBoolSettingName::LimitFramerateOnBattery=False/g; s/EAresBoolSettingName::LimitFramerateInMenu=.*/EAresBoolSettingName::LimitFramerateInMenu=False/g; s/EAresBoolSettingName::LimitFramerateInBackground=.*/EAresBoolSettingName::LimitFramerateInBackground=False/g; s/EAresBoolSettingName::RawInputBufferEnabled=.*/EAresBoolSettingName::RawInputBufferEnabled=True/g; s/EAresFloatSettingName::MaxFramerateAlways=.*/EAresFloatSettingName::MaxFramerateAlways=500.000000/g; s/EAresBoolSettingName::AdaptiveSharpenEnabled=.*/EAresBoolSettingName::AdaptiveSharpenEnabled=True/g; s/EAresIntSettingName::BloomQuality=.*/EAresIntSettingName::BloomQuality=0/g; s/EAresBoolSettingName::DisableDistortion=.*/EAresBoolSettingName::DisableDistortion=True/g; s/EAresBoolSettingName::ShadowsEnabled=.*/EAresBoolSettingName::ShadowsEnabled=False/g; s/EAresBoolSettingName::EnableHRTF=.*/EAresBoolSettingName::EnableHRTF=True/g; s/EAresIntSettingName::MaterialQuality=.*/EAresIntSettingName::MaterialQuality=0/g; s/EAresIntSettingName::DetailQuality=.*/EAresIntSettingName::DetailQuality=0/g; s/EAresIntSettingName::AntiAliasing=.*/EAresIntSettingName::AntiAliasing=1/g; s/EAresFloatSettingName::MaxFramerateInBackground=.*/EAresFloatSettingName::MaxFramerateInBackground=500.000000/g; s/EAresFloatSettingName::MaxFramerateInMenu=.*/EAresFloatSettingName::MaxFramerateInMenu=500.000000/g; s/EAresFloatSettingName::MaxFramerateOnBattery=.*/EAresFloatSettingName::MaxFramerateOnBattery=500.000000/g;" RiotUserSettings.ini
del /F /Q sed*
%SYSTEMROOT%\System32\attrib.exe +r "GameUserSettings.ini"
%SYSTEMROOT%\System32\attrib.exe +r "RiotUserSettings.ini"
echo Done
pause
