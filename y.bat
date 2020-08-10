@ECHO OFF
ECHO '=*=*=*=*=*=*=*=*=*=Executing Prologue: Setting the URL=*=*=*=*=*=*=*=*=*='
SET /P URL="[Enter video URL] "
ECHO '=*=                                                                       =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Part 1: Downloading the Video=*=*=*=*=*=*=*=*=*='
youtube-dl %URL%
ECHO '=*=                                                                      =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Part 2: Getting the Filename=*=*=*=*=*=*=*=*=*='
for /f "delims=" %%a in ('youtube-dl --get-filename "%URL%"') do @set fileLocation=%%a
ECHO %fileLocation%
ECHO '=*=                                                                                              =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Part 3: Replacing Filename(s) Spaces With Underscore=*=*=*=*=*=*=*=*=*='
cd %UserProfile%\Videos\youtube-dl
Setlocal enabledelayedexpansion
Set "Pattern= "
Set "Replace=_"

For %%a in (*.mp4) Do (
    Set "File=%%~a"
    Ren "%%a" "!File:%Pattern%=%Replace%!"
)
ECHO 'Filename underscoring replacement complete'
ECHO '=*=                                                                                           =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Part 4: Replacing Variable Spaces With Underscore=*=*=*=*=*=*=*=*=*='
set file=%fileLocation: =_%
ECHO %file%
ECHO '=*=                                                                              =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Part 5: Re-Encoding Video To Use AAC=*=*=*=*=*=*=*=*=*='
ffmpeg -y -i "%file%" -codec:a aac output.mp4
ECHO 'Re-encoding complete'
ECHO '=*=                                                                 =*='

ECHO '=*=*=*=*=*=*=*=*=*=Executing Epilogue: Final Cleanup=*=*=*=*=*=*=*=*=*='
del %file%
set substring=%file:~33%
ren "output.mp4" "%substring%"
IF EXIST %fileLocation%(
del "%fileLocation%"
)

ECHO 'Done, enjoy using your video :)'