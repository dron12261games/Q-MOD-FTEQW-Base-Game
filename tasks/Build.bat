@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

call :log "[Build] Preparing Windows build environment"
call "%ROOT%\tasks\Clean.bat"

pushd "%ROOT%\base\src" || exit /b 1
call :log "[Build] Compiling progs.dat"
set "_tmp=%TEMP%\fteqcc_progs_%RANDOM%.log"
"%ROOT%\windows\compiler\fteqcc64.exe" -DNOT_QSS= -DNOT_DP= -srcfile progs.src > "%_tmp%" 2>&1
for /f "usebackq delims=" %%L in ("%_tmp%") do call :log "[Build] %%~L"
del /f /q "%_tmp%" >nul 2>&1
if not exist "%ROOT%\base\progs.dat" (
  echo ERROR: progs.dat was not generated
  exit /b 1
)

call :log "[Build] Compiling csprogs.dat"
set "_tmp=%TEMP%\fteqcc_csprogs_%RANDOM%.log"
"%ROOT%\windows\compiler\fteqcc64.exe" -DNOT_QSS= -DNOT_DP= -srcfile csprogs.src > "%_tmp%" 2>&1
for /f "usebackq delims=" %%L in ("%_tmp%") do call :log "[Build] %%~L"
del /f /q "%_tmp%" >nul 2>&1
if not exist "%ROOT%\base\csprogs.dat" (
  echo ERROR: csprogs.dat was not generated
  exit /b 1
)

call :log "[Build] Compiling menu.dat"
set "_tmp=%TEMP%\fteqcc_menu_%RANDOM%.log"
"%ROOT%\windows\compiler\fteqcc64.exe" -DNOT_QSS= -DNOT_DP= -srcfile menu.src > "%_tmp%" 2>&1
for /f "usebackq delims=" %%L in ("%_tmp%") do call :log "[Build] %%~L"
del /f /q "%_tmp%" >nul 2>&1
if not exist "%ROOT%\base\menu.dat" (
  echo ERROR: menu.dat was not generated
  exit /b 1
)

call :log "[Build] Success: progs.dat, csprogs.dat, and menu.dat generated in %ROOT%\base"
popd
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
