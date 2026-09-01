@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

call :log "[Launch] Starting FTEQW in base game mode"
"%ROOT%\windows\fteqw64.exe" -game base
call :log "[Launch] Closed"

endlocal
exit /b 0

:log
set "_d=%DATE%"
set "_t=%TIME%"
set "_d=%_d:/=-%"
set "_t=%_t: =0%"
set "_t=%_t:~0,8%.%_t:~9,2%"
echo [%_d% %_t%] %~1
exit /b 0
