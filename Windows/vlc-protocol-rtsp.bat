@echo off
Setlocal EnableDelayedExpansion
set url_full=%~1
set url=%url_full:~4%
start "VLC" "%~dp0vlc.exe" --open %url%
