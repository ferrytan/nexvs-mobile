#!/bin/bash

# NEXVS Test Script
# This script runs tests with coverage

echo "🧪 Running tests..."

# Run tests with coverage
flutter test --coverage

if [ $? -eq 0 ]; then
  echo "✅ All tests passed!"
  echo "📊 Coverage report generated in coverage/ directory"

  # Optional: Open coverage report on macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    open coverage/lcov.info/index.html 2>/dev/null || echo "To view coverage, open coverage/lcov.info/index.html in a browser"
  fi
else
  echo "❌ Tests failed!"
  exit 1
fi
