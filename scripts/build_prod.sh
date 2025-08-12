#!/bin/bash

echo "Building SmartPace Prod flavor..."

# Build for Android
echo "Building for Android..."
flutter build apk --flavor prod --target lib/main_prod.dart

# Build for iOS (requires manual configuration in Xcode first)
echo "Building for iOS..."
flutter build ios --flavor prod --target lib/main_prod.dart --no-codesign

echo "Prod build complete!"
echo "Android APK: build/app/outputs/flutter-apk/app-prod-debug.apk"
echo "iOS: build/ios/iphoneos/Runner.app"
