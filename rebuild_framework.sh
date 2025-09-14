#!/bin/bash
echo "🔧 Rebuilding Flutter framework..."

# Clean và rebuild
flutter clean
flutter pub get

# Install iOS dependencies
cd ios
pod install --repo-update
cd ..

# Build iOS
flutter build ios --debug --no-codesign

echo "✅ Framework rebuild completed!"
