@echo off
Setlocal EnableDelayedExpansion
set url_full=%~1
set url=%url_full:~4%
set file_name=%~nx1
set file=%tmp%\%file_name%

cd "%~dp0"
powershell -Command "(New-Object Net.WebClient).DownloadFile(\"%url%\", \"%file%\")"
start "VLC" "%~dp0vlc.exe" --vlm-conf %file%
