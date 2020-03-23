#!/bin/bash
set -evo pipefail

if [[ $USE_SPM = 'true' ]]; then
  swift test --enable-test-discovery
else
  xcodebuild \
    -workspace "$WORKSPACE" \
    -scheme "$SCHEME" \
    -sdk "$SDK" \
    -destination "$DESTINATION" \
    -configuration Debug \
    ONLY_ACTIVE_ARCH=YES \
    clean test | xcpretty -c;
fi
