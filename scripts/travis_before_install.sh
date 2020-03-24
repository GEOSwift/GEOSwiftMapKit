#!/bin/bash
set -evo pipefail

if [[ $USE_SPM != 'true' ]]; then
  brew upgrade carthage swiftlint
  gem install xcpretty
  carthage update \
    --cache-builds \
    --platform "$PLATFORM" \
    --no-use-binaries
fi
