@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

call :log "[Clean] Removing generated build artifacts"
 del /f /q "%ROOT%\base\progs.dat" "%ROOT%\base\csprogs.dat" "%ROOT%\base\menu.dat" "%ROOT%\base\progs.lno" "%ROOT%\base\csprogs.lno" "%ROOT%\base\menu.lno" 2>nul
call :log "[Clean] Success: build artifacts removed"

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
