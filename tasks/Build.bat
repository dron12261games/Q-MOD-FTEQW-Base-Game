@echo off
setlocal
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"

call "%ROOT%\tasks\Clean.bat"

pushd "%ROOT%\base" || exit /b 1
"%ROOT%\windows\compiler\fteqcc64.exe" -srcfile progs.src
"%ROOT%\windows\compiler\fteqcc64.exe" -srcfile csprogs.src
popd

endlocal
