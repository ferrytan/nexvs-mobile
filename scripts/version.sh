#!/bin/bash

# Auto-versioning script for Flutter
# Usage: ./scripts/version.sh [version_type] [--build]
# version_type: major, minor, patch (default: patch)
# --build: Automatically build AAB after versioning

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ANDROID_DIR="$PROJECT_ROOT/android"

# Parse arguments
VERSION_TYPE="patch"
SHOULD_BUILD=false

while [[ $# -gt 0 ]]; do
  case $1 in
    major|minor|patch)
      VERSION_TYPE=$1
      shift
      ;;
    --build)
      SHOULD_BUILD=true
      shift
      ;;
    *)
      echo -e "${RED}Error: Unknown argument '$1'${NC}"
      echo "Usage: $0 [major|minor|patch] [--build]"
      exit 1
      ;;
  esac
done

# Default to patch version if no argument provided
VERSION_TYPE=${VERSION_TYPE:-patch}

# Get current version from pubspec.yaml
CURRENT_VERSION=$(grep "^version:" "$PROJECT_ROOT/pubspec.yaml" | sed 's/version: //')
CURRENT_BUILD_NAME=$(echo "$CURRENT_VERSION" | cut -d'+' -f1)
CURRENT_BUILD_NUMBER=$(echo "$CURRENT_VERSION" | cut -d'+' -f2)

# Parse current version
MAJOR=$(echo "$CURRENT_BUILD_NAME" | cut -d'.' -f1)
MINOR=$(echo "$CURRENT_BUILD_NAME" | cut -d'.' -f2)
PATCH=$(echo "$CURRENT_BUILD_NAME" | cut -d'.' -f3)

# Increment version based on type
case $VERSION_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
esac

# New version
NEW_BUILD_NAME="$MAJOR.$MINOR.$PATCH"
NEW_BUILD_NUMBER=$((CURRENT_BUILD_NUMBER + 1))
NEW_VERSION="$NEW_BUILD_NAME+$NEW_BUILD_NUMBER"

echo -e "${YELLOW}Current version: $CURRENT_VERSION${NC}"
echo -e "${GREEN}New version: $NEW_VERSION${NC}"

# Update pubspec.yaml
sed -i '' "s/^version: $CURRENT_VERSION/version: $NEW_VERSION/" "$PROJECT_ROOT/pubspec.yaml"

# Update local.properties with version info for Gradle (local only, not committed)
LOCAL_PROPS="$ANDROID_DIR/local.properties"
if [ -f "$LOCAL_PROPS" ]; then
  # Remove existing version and build mode lines
  sed -i '' '/^flutter.versionName=/d' "$LOCAL_PROPS"
  sed -i '' '/^flutter.versionCode=/d' "$LOCAL_PROPS"
  sed -i '' '/^flutter.buildMode=/d' "$LOCAL_PROPS"
  # Add new version lines
  echo "flutter.versionName=$NEW_BUILD_NAME" >> "$LOCAL_PROPS"
  echo "flutter.versionCode=$NEW_BUILD_NUMBER" >> "$LOCAL_PROPS"
  echo "flutter.buildMode=release" >> "$LOCAL_PROPS"
  echo -e "${GREEN}✓ Updated local.properties (not committed, machine-specific)${NC}"
fi

# Create git tag
TAG_NAME="v$NEW_BUILD_NAME"
echo -e "${YELLOW}Creating git tag: $TAG_NAME${NC}"
git tag -a "$TAG_NAME" -m "Release $NEW_BUILD_NAME"
git add "$PROJECT_ROOT/pubspec.yaml"

# Commit pubspec.yaml
echo -e "${BLUE}Committing version changes...${NC}"
git commit -m "chore: bump version to $NEW_VERSION"

echo -e "${GREEN}✓ Version updated to $NEW_VERSION${NC}"
echo -e "${YELLOW}Don't forget to push!${NC}"
echo -e "  git push origin main"
echo -e "  git push origin $TAG_NAME"

# Build AAB if requested
if [ "$SHOULD_BUILD" = true ]; then
  echo -e "${BLUE}Building AAB...${NC}"
  cd "$ANDROID_DIR"
  ./gradlew clean bundleRelease
  echo -e "${GREEN}✓ AAB built successfully${NC}"
  echo -e "${BLUE}Location: $PROJECT_ROOT/build/app/outputs/bundle/release/app-release.aab${NC}"
fi
