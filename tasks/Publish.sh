#!/usr/bin/env bash
set -eux
shopt -s nullglob dotglob
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Publish] Cleaning previous output"
"$ROOT/tasks/CleanPublish.sh"
log "[Publish] Building fresh artifacts"
"$ROOT/tasks/Build.sh"
OUTROOT="$ROOT/out"
rm -rf "$OUTROOT"

copy_base_files() {
  local dst="$1"
  mkdir -p "$dst"

  find "$ROOT/base" -mindepth 1 -maxdepth 1 \
    ! -name 'csqc' \
    ! -name 'ssqc' \
    ! -name 'progs.src' \
    ! -name 'csprogs.src' \
    ! -name 'progs.lno' \
    ! -name 'csprogs.lno' \
    -exec cp -a -- {} "$dst/" \;
}

copy_platform_files() {
  local platform="$1"
  local src_dir="$ROOT/$platform"
  local out_dir="$OUTROOT/$platform"

  echo "[Publish] DEBUG src_dir=$src_dir out_dir=$out_dir"
  ls -la "$ROOT/base" || true
  ls -la "$src_dir" || true

  mkdir -p "$out_dir/base"
  copy_base_files "$out_dir/base"

  find "$src_dir" -mindepth 1 -maxdepth 1 \
    ! -name 'compiler' \
    -exec cp -a -- {} "$out_dir/" \;

  rm -rf "$out_dir/compiler"

  [ -f "$ROOT/default.fmf" ] && cp "$ROOT/default.fmf" "$out_dir/"
  [ -f "$ROOT/maptimes.txt" ] && cp "$ROOT/maptimes.txt" "$out_dir/"
}

log "[Publish] Packaging Windows build"
copy_platform_files windows || {
  echo "ERROR: failed to package Windows build" >&2
  exit 1
}

log "[Publish] Packaging Linux build"
copy_platform_files linux || {
  echo "ERROR: failed to package Linux build" >&2
  exit 1
}

log "[Publish] Success: packages created in $OUTROOT"
