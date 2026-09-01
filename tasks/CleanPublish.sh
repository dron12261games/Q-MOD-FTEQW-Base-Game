#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Clean Publish] Removing publish output"
rm -rf "$ROOT/out"
log "[Clean Publish] Success: publish output removed"
