#!/usr/bin/env bash
set -eu
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

  for item in "$ROOT/base"/*; do
    [ -e "$item" ] || continue
    name="${item##*/}"
    case "$name" in
      csqc|ssqc|progs.src|csprogs.src|progs.lno|csprogs.lno)
        continue
        ;;
      *)
        cp -a -- "$item" "$dst/"
        ;;
    esac
  done
}

copy_platform_files() {
  local platform="$1"
  local src_dir="$ROOT/$platform"
  local out_dir="$OUTROOT/$platform"

  mkdir -p "$out_dir/base"
  copy_base_files "$out_dir/base"

  for item in "$src_dir"/*; do
    [ -e "$item" ] || continue
    name="${item##*/}"
    [ "$name" = "compiler" ] && continue
    cp -a -- "$item" "$out_dir/"
  done

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
