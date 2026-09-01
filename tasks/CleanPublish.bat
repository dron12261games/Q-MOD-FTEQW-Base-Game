@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"
set "OUT=%ROOT%\out"

call :log "[Clean Publish] Removing publish output"
if exist "%OUT%" rmdir /s /q "%OUT%"
call :log "[Clean Publish] Success: publish output removed"

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
