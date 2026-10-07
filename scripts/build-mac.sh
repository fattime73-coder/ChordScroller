#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

swift build -c release

APP="$ROOT/build/ChordScroller.app"
CONTENTS="$APP/Contents"
MACOS="$CONTENTS/MacOS"
rm -rf "$APP"
mkdir -p "$MACOS" "$CONTENTS/Resources"
cp "$ROOT/.build/release/ChordScroller" "$MACOS/ChordScroller"
cp "$ROOT/Info.plist" "$CONTENTS/Info.plist"
chmod +x "$MACOS/ChordScroller"

echo "Built: $APP"
echo "Open with: open \"$APP\""
