#!/usr/bin/env bash
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Build] Preparing Linux build environment"
chmod +x "$ROOT/linux/compiler/"* "$ROOT/linux/"fteqw* 2>/dev/null || true
"$ROOT/tasks/Clean.sh"
cd "$ROOT/base"

log "[Build] Compiling progs.dat"
set +e
"$ROOT/linux/compiler/fteqcc64" -DNOT_QSS= -DNOT_DP= -srcfile progs.src 2>&1 | sed -u 's/^/[Build] /'
status=${PIPESTATUS[0]}
set -e
if [ "$status" -ne 0 ]; then
  echo "ERROR: progs.dat compilation failed" >&2
  exit 1
fi
if [ ! -f "$ROOT/base/progs.dat" ]; then
  echo "ERROR: progs.dat was not generated" >&2
  exit 1
fi

log "[Build] Compiling csprogs.dat"
set +e
"$ROOT/linux/compiler/fteqcc64" -DNOT_QSS= -DNOT_DP= -srcfile csprogs.src 2>&1 | sed -u 's/^/[Build] /'
status=${PIPESTATUS[0]}
set -e
if [ "$status" -ne 0 ]; then
  echo "ERROR: csprogs.dat compilation failed" >&2
  exit 1
fi
if [ ! -f "$ROOT/base/csprogs.dat" ]; then
  echo "ERROR: csprogs.dat was not generated" >&2
  exit 1
fi

log "[Build] Success: progs.dat and csprogs.dat generated in $ROOT/base"
