#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/base"
"$ROOT/linux/compiler/fteqcc64" -srcfile progs.src
"$ROOT/linux/compiler/fteqcc64" -srcfile csprogs.src
