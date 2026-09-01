$root = $PSScriptRoot
$compiler = Join-Path $root "Compiler\fteqcc64.exe"
$serverSrc = Join-Path $root "base\progs.src"
$clientSrc = Join-Path $root "base\csprogs.src"

& $compiler -srcfile $serverSrc
& $compiler -srcfile $clientSrc
