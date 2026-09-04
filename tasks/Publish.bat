@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

call :log "[Publish] Cleaning previous output"
call "%ROOT%\tasks\CleanPublish.bat"
call :log "[Publish] Building fresh artifacts"
call "%ROOT%\tasks\Build.bat"

set "OUTROOT=%ROOT%\out"
if exist "%OUTROOT%" rmdir /s /q "%OUTROOT%"

set "WINOUT=%OUTROOT%\windows"
set "LINOUT=%OUTROOT%\linux"
mkdir "%WINOUT%\base" >nul
mkdir "%LINOUT%\base" >nul

call :log "[Publish] Packaging Windows build"
robocopy "%ROOT%\base" "%WINOUT%\base" * /XD src /XF *.lno /NFL /NDL /NJH /NJS >nul
robocopy "%ROOT%\windows" "%WINOUT%" * /XD compiler /NFL /NDL /NJH /NJS >nul

call :log "[Publish] Packaging Linux build"
robocopy "%ROOT%\base" "%LINOUT%\base" * /XD src /XF *.lno /NFL /NDL /NJH /NJS >nul
robocopy "%ROOT%\linux" "%LINOUT%" * /XD compiler /NFL /NDL /NJH /NJS >nul

if exist "%ROOT%\default.fmf" copy /Y "%ROOT%\default.fmf" "%WINOUT%\" >nul
if exist "%ROOT%\default.fmf" copy /Y "%ROOT%\default.fmf" "%LINOUT%\" >nul

call :log "[Publish] Success: packages created in %OUTROOT%"

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
