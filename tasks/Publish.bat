@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

set "OUTROOT=%ROOT%\out"
if exist "%OUTROOT%" rmdir /s /q "%OUTROOT%"

set "WINOUT=%OUTROOT%\windows"
set "LINOUT=%OUTROOT%\linux"
mkdir "%WINOUT%\base" >nul
mkdir "%LINOUT%\base" >nul

robocopy "%ROOT%\base" "%WINOUT%\base" * /XD csqc ssqc /XF progs.src csprogs.src progs.lno csprogs.lno /NFL /NDL /NJH /NJS >nul
robocopy "%ROOT%\base" "%LINOUT%\base" * /XD csqc ssqc /XF progs.src csprogs.src progs.lno csprogs.lno /NFL /NDL /NJH /NJS >nul

robocopy "%ROOT%\windows" "%WINOUT%" * /XD compiler /NFL /NDL /NJH /NJS >nul
robocopy "%ROOT%\linux" "%LINOUT%" * /XD compiler /NFL /NDL /NJH /NJS >nul

if exist "%ROOT%\default.fmf" copy /Y "%ROOT%\default.fmf" "%WINOUT%\" >nul
if exist "%ROOT%\default.fmf" copy /Y "%ROOT%\default.fmf" "%LINOUT%\" >nul
if exist "%ROOT%\maptimes.txt" copy /Y "%ROOT%\maptimes.txt" "%WINOUT%\" >nul
if exist "%ROOT%\maptimes.txt" copy /Y "%ROOT%\maptimes.txt" "%LINOUT%\" >nul

endlocal
