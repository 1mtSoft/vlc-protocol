@echo off
Setlocal EnableDelayedExpansion
set command=%~1
set url=%~2
set url=!url: =%%20!
start "VLC" "%~dp0vlc.exe" %command% "%url:~6%"