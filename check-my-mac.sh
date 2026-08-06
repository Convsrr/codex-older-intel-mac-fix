#!/bin/bash

set -u

GUMROAD_URL="https://convsrr.gumroad.com/l/codex-older-mac-fix"
APP="/Applications/ChatGPT.app"

echo
echo "Codex / ChatGPT Mac Compatibility Check"
echo "========================================"
echo

ARCHITECTURE="$(uname -m 2>/dev/null || echo unknown)"
MACOS_VERSION="$(sw_vers -productVersion 2>/dev/null || echo unknown)"
MAC_MODEL="$(system_profiler SPHardwareDataType 2>/dev/null | awk -F': ' '/Model Name/{print $2; exit}')"
MAC_IDENTIFIER="$(system_profiler SPHardwareDataType 2>/dev/null | awk -F': ' '/Model Identifier/{print $2; exit}')"

echo "Mac model:        ${MAC_MODEL:-Unknown}"
echo "Model identifier: ${MAC_IDENTIFIER:-Unknown}"
echo "Architecture:     $ARCHITECTURE"
echo "macOS version:    $MACOS_VERSION"
echo

case "$ARCHITECTURE" in
  x86_64)
    echo "Architecture result: Intel Mac detected."
    ;;
  arm64)
    echo "Architecture result: Apple Silicon detected."
    echo "This repository focuses on older Intel Macs."
    ;;
  *)
    echo "Architecture result: Unrecognised architecture."
    ;;
esac

if [[ -d "$APP" ]]; then
  INFO_PLIST="$APP/Contents/Info.plist"

  VERSION="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$INFO_PLIST" 2>/dev/null || true)"
  BUILD="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$INFO_PLIST" 2>/dev/null || true)"
  MINIMUM_MACOS="$(/usr/libexec/PlistBuddy -c 'Print :LSMinimumSystemVersion' "$INFO_PLIST" 2>/dev/null || true)"

  echo
  echo "Installed ChatGPT application found:"
  echo "Path:             $APP"
  echo "App version:      ${VERSION:-Unknown}"
  echo "Build number:     ${BUILD:-Unknown}"
  echo "Minimum macOS:    ${MINIMUM_MACOS:-Not specified}"
  echo

  echo "Code-signature check:"
  if codesign --verify --deep --strict --verbose=2 "$APP" >/tmp/codex-signature-check.txt 2>&1; then
    echo "PASS — the application signature verified."
  else
    echo "FAIL — the application signature did not verify."
    sed -n '1,8p' /tmp/codex-signature-check.txt
  fi

  echo
  echo "Gatekeeper assessment:"
  if spctl -a -vv "$APP" >/tmp/codex-gatekeeper-check.txt 2>&1; then
    echo "PASS — Gatekeeper accepted the application."
  else
    echo "NOT ACCEPTED — review the result before opening the app."
  fi
  sed -n '1,8p' /tmp/codex-gatekeeper-check.txt

  rm -f /tmp/codex-signature-check.txt /tmp/codex-gatekeeper-check.txt
else
  echo
  echo "No ChatGPT.app was found at:"
  echo "$APP"
fi

echo
echo "This checker did not install, delete or modify any application or data."
echo
echo "Complete tested rollback guide:"
echo "$GUMROAD_URL"
echo