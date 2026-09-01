#!/usr/bin/env bash
set -eu
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

create_platform_copy() {
  local platform="$1"
  local src_dir="$ROOT/$platform"
  local out_dir="$OUTROOT/$platform"
  mkdir -p "$out_dir/base"

  for item in "$ROOT/base"/*; do
    name="$(basename "$item")"
    case "$name" in
      csqc|ssqc|progs.src|csprogs.src|progs.lno|csprogs.lno)
        continue
        ;;
      *)
        cp -a "$item" "$out_dir/base/"
        ;;
    esac
  done

  cp -a "$src_dir/." "$out_dir/"
  rm -rf "$out_dir/compiler"

  [ -f "$ROOT/default.fmf" ] && cp "$ROOT/default.fmf" "$out_dir/"
  [ -f "$ROOT/maptimes.txt" ] && cp "$ROOT/maptimes.txt" "$out_dir/"
}

log "[Publish] Packaging Windows build"
create_platform_copy windows

log "[Publish] Packaging Linux build"
create_platform_copy linux

log "[Publish] Success: packages created in $OUTROOT"
