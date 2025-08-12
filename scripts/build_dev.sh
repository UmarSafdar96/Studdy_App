#!/bin/bash

echo "Building SmartPace Dev flavor..."

# Build for Android
echo "Building for Android..."
flutter build apk --flavor dev --target lib/main_dev.dart

# Build for iOS (requires manual configuration in Xcode first)
echo "Building for iOS..."
flutter build ios --flavor dev --target lib/main_dev.dart --no-codesign

echo "Dev build complete!"
echo "Android APK: build/app/outputs/flutter-apk/app-dev-debug.apk"
echo "iOS: build/ios/iphoneos/Runner.app"
