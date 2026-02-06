#!/bin/bash

# NEXVS Build Script
# This script builds the app for different platforms

PLATFORM=${1:-all}

echo "🏗️  Building NEXVS for $PLATFORM..."

case $PLATFORM in
  android)
    flutter build apk --release
    flutter build appbundle --release
    ;;
  ios)
    flutter build ios --release
    ;;
  all)
    flutter build apk --release
    flutter build appbundle --release
    flutter build ios --release
    ;;
  *)
    echo "❌ Unknown platform: $PLATFORM"
    echo "Usage: ./build.sh [android|ios|all]"
    exit 1
    ;;
esac

if [ $? -eq 0 ]; then
  echo "✅ Build completed successfully!"
else
  echo "❌ Build failed!"
  exit 1
fi
