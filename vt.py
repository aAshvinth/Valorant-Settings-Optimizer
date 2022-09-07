with open('GameUserSettings.ini', 'r', encoding='utf-8') as file:
    settings = file.readlines()

settings[5] ='bShouldLetterbox=False \n'
settings[7] ='bUseVSync=False \n'
settings[11] ='LastUserConfirmedResolutionSizeX=1280 \n'
settings[12] ='LastUserConfirmedResolutionSizeY=720 \n'
settings[19] ='FrameRateLimit=0.000000 \n'  
settings[20] ='DesiredScreenWidth=1280 \n'  
settings[21] ='DesiredScreenHeight=720 \n'  
settings[22] ='LastUserConfirmedDesiredScreenWidth=1280 \n'
settings[23] ='LastUserConfirmedDesiredScreenHeight=720 \n'
settings[29] ='bUseHDRDisplayOutput=False \n'
settings[33] ='bUseDesiredScreenHeight=True \n'
settings[36] ='sg.ResolutionQuality=65.000000 \n'
settings[37] ='sg.ViewDistanceQuality=1 \n'
settings[38] ='sg.AntiAliasingQuality=0 \n'
settings[39] ='sg.ShadowQuality=0 \n'
settings[40] ='sg.PostProcessQuality=0 \n'
settings[41] ='sg.TextureQuality=0e \n'
settings[42] ='sg.EffectsQuality=0 \n'
settings[43] ='sg.FoliageQuality=0 \n'
settings[44] ='sg.ShadingQuality=0 \n'

print(settings)

with open('GameUserSettings.ini', 'w', encoding='utf-8') as file:
   file.writelines(settings)


