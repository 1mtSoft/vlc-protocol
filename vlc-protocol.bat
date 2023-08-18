@echo off
Setlocal EnableDelayedExpansion
set command=%~1
set url_full=%~2
set url=%url_full:~6%
set file_name=%~nx2
set file=%tmp%\%file_name%
powershell -Command "(New-Object Net.WebClient).DownloadFile(\"%url%\", \"%file%\")"
start "VLC" "%~dp0vlc.exe" %command% %file%
