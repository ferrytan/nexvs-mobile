#!/bin/bash

# NEXVS Clean Script
# This script cleans the Flutter project and removes generated files

echo "🧹 Cleaning Flutter project..."

# Clean Flutter
flutter clean

# Remove generated files
find . -name "*.g.dart" -type f -delete
find . -name "*.freezed.dart" -type f -delete
find . -name "*.mocks.dart" -type f -delete

echo "✅ Clean completed!"
