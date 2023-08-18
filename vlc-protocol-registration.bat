@echo off

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Error: Run the file as administrator.
	pause
	exit /b
)

set vlc_dir=""

if not exist "C:\Program Files\VideoLAN\VLC\vlc.exe" (
  if not exist "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" (
    echo Can't find vlc.exe.
    pause
    exit /b
  ) else (
    set vlc_dir="C:\Program Files (x86)\VideoLAN\VLC"
  )
) else (
  set vlc_dir="C:\Program Files\VideoLAN\VLC"
)

echo Removing vlc:// association.
reg delete HKCR\vlc /f

echo Removing vlm:// association.
reg delete HKCR\vlm /f

if exist "%vlc_dir:"=%\vlc-protocol-rtsp.bat" (
  echo Deleting vlc-protocol-rtsp.bat
  del /F /Q "%vlc_dir:"=%\vlc-protocol-rtsp.bat"
)

if exist "%vlc_dir:"=%\vlc-protocol-vlm.bat" (
  echo Deleting vlc-protocol-vlm.bat
  del /F /Q "%vlc_dir:"=%\vlc-protocol-vlm.bat"
)

if exist "%vlc_dir:"=%\bg_1x1_1920x1080.png" (
  echo Deleting bg_1x1_1920x1080.png
  del /F /Q "%vlc_dir:"=%\bg_1x1_1920x1080.png"
)

if exist "%vlc_dir:"=%\bg_2x1_1920x1080.png" (
  echo Deleting bg_2x1_1920x1080.png
  del /F /Q "%vlc_dir:"=%\bg_2x1_1920x1080.png"
)

if exist "%vlc_dir:"=%\bg_2x2_1920x1080.png" (
  echo Deleting bg_2x2_1920x1080.png
  del /F /Q "%vlc_dir:"=%\bg_2x2_1920x1080.png"
)

if exist "%vlc_dir:"=%\bg_3x2_1920x1080.png" (
  echo Deleting bg_3x2_1920x1080.png
  del /F /Q "%vlc_dir:"=%\bg_3x2_1920x1080.png"
)

if exist "%vlc_dir:"=%\bg_3x3_1920x1080.png" (
  echo Deleting bg_3x3_1920x1080.png
  del /F /Q "%vlc_dir:"=%\bg_3x3_1920x1080.png"
)

echo Copy vlc-protocol-rtsp.bat to %vlc_dir%
copy /Y "%~dp0vlc-protocol-rtsp.bat" "%vlc_dir:"=%\vlc-protocol-rtsp.bat"

echo Copy vlc-protocol-vlm.bat to %vlc_dir%
copy /Y "%~dp0vlc-protocol-vlm.bat" "%vlc_dir:"=%\vlc-protocol-vlm.bat"

echo Copy bg_1x1_1920x1080.png to %vlc_dir%
copy /Y "%~dp0bg_1x1_1920x1080.png" "%vlc_dir:"=%\bg_1x1_1920x1080.png"

echo Copy bg_2x1_1920x1080.png to %vlc_dir%
copy /Y "%~dp0bg_2x1_1920x1080.png" "%vlc_dir:"=%\bg_2x1_1920x1080.png"

echo Copy bg_2x2_1920x1080.png to %vlc_dir%
copy /Y "%~dp0bg_2x2_1920x1080.png" "%vlc_dir:"=%\bg_2x2_1920x1080.png"

echo Copy bg_3x2_1920x1080.png to %vlc_dir%
copy /Y "%~dp0bg_3x2_1920x1080.png" "%vlc_dir:"=%\bg_3x2_1920x1080.png"

echo Copy bg_3x3_1920x1080.png to %vlc_dir%
copy /Y "%~dp0bg_3x3_1920x1080.png" "%vlc_dir:"=%\bg_3x3_1920x1080.png"

echo Associating vlc:// with vlc-protocol.bat.
reg add HKCR\vlc /ve /t REG_SZ /d "URL:vlc Protocol" /f
reg add HKCR\vlc /v "URL Protocol" /t REG_SZ /d "" /f
reg add HKCR\vlc\DefaultIcon /ve /t REG_SZ /d "%vlc_dir:"=%\vlc.exe,0" /f
reg add HKCR\vlc\shell\open\command /ve /t REG_SZ /d "\"%vlc_dir:"=%\vlc-protocol-rtsp.bat\" \"%%1\"" /f

echo Associating vlm:// with vlc-protocol.bat.
reg add HKCR\vlm /ve /t REG_SZ /d "URL:vlm Protocol" /f
reg add HKCR\vlm /v "URL Protocol" /t REG_SZ /d "" /f
reg add HKCR\vlm\DefaultIcon /ve /t REG_SZ /d "%vlc_dir:"=%\vlc.exe,0" /f
reg add HKCR\vlm\shell\open\command /ve /t REG_SZ /d "\"%vlc_dir:"=%\vlc-protocol-vlm.bat\" \"%%1\"" /f

@echo.
pause
