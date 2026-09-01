@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"
set "OUT=%ROOT%\out"
if exist "%OUT%" rmdir /s /q "%OUT%"
endlocal
