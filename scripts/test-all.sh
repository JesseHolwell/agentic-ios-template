#!/bin/bash
# Run all tests (unit + UI). Exits non-zero if any test fails.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Running all tests..."

"$SCRIPT_DIR/test-unit.sh"
"$SCRIPT_DIR/test-ui.sh"

echo "==> All tests passed."
