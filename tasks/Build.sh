#!/usr/bin/env bash
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Build] Preparing Linux build environment"
chmod +x "$ROOT/linux/compiler/"* "$ROOT/linux/"fteqw* 2>/dev/null || true
"$ROOT/tasks/Clean.sh"
cd "$ROOT/base/src"

log "[Build] Compiling progs.dat"
set +e
log_file="$(mktemp)"
"$ROOT/linux/compiler/fteqcc64" -DNOT_QSS= -DNOT_DP= -srcfile progs.src >"$log_file" 2>&1
status=$?
while IFS= read -r line; do
  log "[Build] $line"
done < "$log_file"
rm -f "$log_file"
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
log_file="$(mktemp)"
"$ROOT/linux/compiler/fteqcc64" -DNOT_QSS= -DNOT_DP= -srcfile csprogs.src >"$log_file" 2>&1
status=$?
while IFS= read -r line; do
  log "[Build] $line"
done < "$log_file"
rm -f "$log_file"
set -e
if [ "$status" -ne 0 ]; then
  echo "ERROR: csprogs.dat compilation failed" >&2
  exit 1
fi
if [ ! -f "$ROOT/base/csprogs.dat" ]; then
  echo "ERROR: csprogs.dat was not generated" >&2
  exit 1
fi

log "[Build] Compiling menu.dat"
set +e
log_file="$(mktemp)"
"$ROOT/linux/compiler/fteqcc64" -DNOT_QSS= -DNOT_DP= -srcfile menu.src >"$log_file" 2>&1
status=$?
while IFS= read -r line; do
  log "[Build] $line"
done < "$log_file"
rm -f "$log_file"
set -e
if [ "$status" -ne 0 ]; then
  echo "ERROR: menu.dat compilation failed" >&2
  exit 1
fi
if [ ! -f "$ROOT/base/menu.dat" ]; then
  echo "ERROR: menu.dat was not generated" >&2
  exit 1
fi

log "[Build] Success: progs.dat, csprogs.dat, and menu.dat generated in $ROOT/base"
