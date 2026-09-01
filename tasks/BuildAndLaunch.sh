#!/usr/bin/env bash
set -eu
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Build.sh"
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Launch.sh"
