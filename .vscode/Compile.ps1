$root = Split-Path -Parent $PSScriptRoot
$compiler = Join-Path $root "Compiler\fteqcc64.exe"
$buildDir = Join-Path $root "base"

Push-Location $buildDir
try {
    & $compiler -srcfile progs.src
    & $compiler -srcfile csprogs.src
}
finally {
    Pop-Location
}
