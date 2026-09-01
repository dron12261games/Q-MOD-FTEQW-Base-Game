#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rm -f "$ROOT/base/progs.dat" "$ROOT/base/csprogs.dat" "$ROOT/base/progs.lno" "$ROOT/base/csprogs.lno"
