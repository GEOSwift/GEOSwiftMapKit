#!/bin/bash
set -evo pipefail

swiftlint
rm -rf GEOSwiftMapKit.xcodeproj
xcodebuild \
    -scheme GEOSwiftMapKit \
    -sdk "$SDK" \
    -destination "$DESTINATION" \
    clean test | xcpretty -c;
