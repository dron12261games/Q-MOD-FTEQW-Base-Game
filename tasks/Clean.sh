#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Clean] Removing generated build artifacts"
rm -f "$ROOT/base/progs.dat" "$ROOT/base/csprogs.dat" "$ROOT/base/menu.dat" "$ROOT/base/progs.lno" "$ROOT/base/csprogs.lno" "$ROOT/base/menu.lno"
log "[Clean] Success: build artifacts removed"
