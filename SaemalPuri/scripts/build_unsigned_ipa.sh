#!/usr/bin/env bash
set -euo pipefail

xcodebuild \
  -project SaemalPuri.xcodeproj \
  -scheme SaemalPuri \
  -configuration Release \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  -derivedDataPath build \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY="" \
  build

rm -rf Payload SaemalPuri_unsigned.ipa
mkdir Payload
cp -R build/Build/Products/Release-iphoneos/SaemalPuri.app Payload/
/usr/bin/zip -qry SaemalPuri_unsigned.ipa Payload

echo "Done: SaemalPuri_unsigned.ipa"
