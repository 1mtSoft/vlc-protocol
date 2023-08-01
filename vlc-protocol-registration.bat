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

if exist "%vlc_dir:"=%\vlc-protocol.bat" (
  echo Deleting vlc-protocol.bat
  del /F /Q "%vlc_dir:"=%\vlc-protocol.bat"
)

if exist "%vlc_dir:"=%\bg.jpg" (
  echo Deleting bg.jpg
  del /F /Q "%vlc_dir:"=%\bg.jpg"
)

echo Copy vlc-protocol.bat to %vlc_dir%
copy /Y "%~dp0vlc-protocol.bat" "%vlc_dir:"=%\vlc-protocol.bat"

echo Copy bg.jpg to %vlc_dir%
copy /Y "%~dp0bg.jpg" "%vlc_dir:"=%\bg.jpg"

echo Associating vlc:// with vlc-protocol.bat.
reg add HKCR\vlc /ve /t REG_SZ /d "URL:vlc Protocol" /f
reg add HKCR\vlc /v "URL Protocol" /t REG_SZ /d "" /f
reg add HKCR\vlc\DefaultIcon /ve /t REG_SZ /d "%vlc_dir:"=%\vlc.exe,0" /f
reg add HKCR\vlc\shell\open\command /ve /t REG_SZ /d "\"%vlc_dir:"=%\vlc-protocol.bat\" --open \"%%1\"" /f

echo Associating vlm:// with vlc-protocol.bat.
reg add HKCR\vlm /ve /t REG_SZ /d "URL:vlm Protocol" /f
reg add HKCR\vlm /v "URL Protocol" /t REG_SZ /d "" /f
reg add HKCR\vlm\DefaultIcon /ve /t REG_SZ /d "%vlc_dir:"=%\vlc.exe,0" /f
reg add HKCR\vlm\shell\open\command /ve /t REG_SZ /d "\"%vlc_dir:"=%\vlc-protocol.bat\" --vlm-conf \"%%1\"" /f

@echo.
pause
