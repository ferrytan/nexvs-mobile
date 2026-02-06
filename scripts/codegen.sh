#!/bin/bash

# NEXVS Code Generation Script
# This script runs the code generation for ObjectBox, Injectable, and other generators

echo "🔧 Running code generation..."

# Run build_runner to generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Check if the command was successful
if [ $? -eq 0 ]; then
  echo "✅ Code generation completed successfully!"
else
  echo "❌ Code generation failed!"
  exit 1
fi
