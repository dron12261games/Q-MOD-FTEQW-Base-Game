$root = Split-Path -Parent $PSScriptRoot
$base = Join-Path $root 'base'
$files = @('progs.dat', 'csprogs.dat', 'progs.lno', 'csprogs.lno')

foreach ($file in $files) {
    $path = Join-Path $base $file
    if (Test-Path $path) {
        Remove-Item $path -Force
    }
}

Write-Host "Cleaned: $base"
