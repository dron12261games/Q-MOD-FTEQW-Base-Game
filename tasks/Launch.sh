#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S.%3N')] $*"
}

log "[Launch] Starting FTEQW in base game mode"
"$ROOT/linux/fteqw64" -game base
log "[Launch] Closed"
