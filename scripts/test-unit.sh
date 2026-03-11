#!/bin/bash
# Run the unit test target only. Exits non-zero on failure.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$REPO_ROOT/AgenticSampleApp.xcodeproj"
SCHEME="AgenticSampleApp"
DESTINATION="${DESTINATION:-platform=iOS Simulator,name=iPhone 16}"

echo "==> Running unit tests..."

xcodebuild test \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -only-testing:AgenticSampleAppTests \
  CODE_SIGNING_ALLOWED=NO

echo "==> Unit tests passed."
