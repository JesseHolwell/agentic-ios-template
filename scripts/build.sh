#!/bin/bash
# Build the app target for a simulator. Exits non-zero on failure.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$REPO_ROOT/AgenticSampleApp.xcodeproj"
SCHEME="AgenticSampleApp"
DESTINATION="${DESTINATION:-platform=iOS Simulator,name=iPhone 16}"

echo "==> Building $SCHEME..."

xcodebuild build \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -configuration Debug \
  CODE_SIGNING_ALLOWED=NO

echo "==> Build succeeded."
