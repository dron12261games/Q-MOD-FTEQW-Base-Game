#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
chmod +x "$ROOT/linux/compiler/"* "$ROOT/linux/"fteqw* 2>/dev/null || true
"$ROOT/tasks/Clean.sh"
cd "$ROOT/base"
"$ROOT/linux/compiler/fteqcc64" -srcfile progs.src
"$ROOT/linux/compiler/fteqcc64" -srcfile csprogs.src
