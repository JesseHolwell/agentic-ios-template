#!/bin/bash
# Run the UI test target only. Exits non-zero on failure.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$REPO_ROOT/AgenticSampleApp.xcodeproj"
SCHEME="AgenticSampleApp"
DESTINATION="${DESTINATION:-platform=iOS Simulator,name=iPhone 16}"

echo "==> Running UI tests..."

xcodebuild test \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -only-testing:AgenticSampleAppUITests \
  CODE_SIGNING_ALLOWED=NO

echo "==> UI tests passed."
