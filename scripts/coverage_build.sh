#!/bin/bash
set -e

cd ..
flutter test --coverage
lcov --remove coverage/lcov.info "**/*.g.dart" "**/*.gr.dart" "**/widgets/*" "**/widget/*" "**/view/*" "**/views/*" "lib/app/core/widgets/*" "lib/src/l10n/generated/*"  -o coverage/lcov_cleaned.info
genhtml coverage/lcov_cleaned.info -o coverage/html

# Open in the default browser (mac):
open coverage/html/index.html