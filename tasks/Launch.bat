@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

"%ROOT%\windows\fteqw64.exe" -game base

endlocal
