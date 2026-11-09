@echo off
setlocal
title Rail Network Builder
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0run-game.ps1"
if errorlevel 1 pause

