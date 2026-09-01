@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

del /f /q "%ROOT%\base\progs.dat" "%ROOT%\base\csprogs.dat" "%ROOT%\base\progs.lno" "%ROOT%\base\csprogs.lno" 2>nul

endlocal
