# SmartPace Flavor Configuration

This project supports two flavors: `dev` and `prod`.

## Flavor Differences

### Dev Flavor
- **App Name**: SmartPace Dev
- **Bundle ID**: com.example.smart_pace.dev
- **Welcome Screen**: Disabled (skips directly to home)
- **Debug Banner**: Enabled
- **Use Case**: Development and testing

### Prod Flavor
- **App Name**: SmartPace
- **Bundle ID**: com.example.smart_pace
- **Welcome Screen**: Enabled (shows welcome module)
- **Debug Banner**: Disabled
- **Use Case**: Production releases

## Running the App

### Using VS Code
1. Open the Debug panel (Ctrl+Shift+D)
2. Select the desired configuration:
   - "SmartPace Dev" - Run dev flavor
   - "SmartPace Prod" - Run prod flavor
   - "SmartPace Dev (Android)" - Run dev flavor on Android
   - "SmartPace Prod (Android)" - Run prod flavor on Android
   - "SmartPace Dev (iOS)" - Run dev flavor on iOS
   - "SmartPace Prod (iOS)" - Run prod flavor on iOS

### Using Command Line

#### Development Flavor
```bash
# Run dev flavor
flutter run --flavor dev --target lib/main_dev.dart

# Build dev APK
flutter build apk --flavor dev --target lib/main_dev.dart

# Build dev iOS
flutter build ios --flavor dev --target lib/main_dev.dart --no-codesign
```

#### Production Flavor
```bash
# Run prod flavor
flutter run --flavor prod --target lib/main_prod.dart

# Build prod APK
flutter build apk --flavor prod --target lib/main_prod.dart

# Build prod iOS
flutter build ios --flavor prod --target lib/main_prod.dart --no-codesign
```

### Using Build Scripts
```bash
# Build dev flavor
./scripts/build_dev.sh

# Build prod flavor
./scripts/build_prod.sh
```

## Android Configuration

The Android flavors are configured in `android/app/build.gradle.kts`:

- **Dev**: `com.example.smart_pace.dev`
- **Prod**: `com.example.smart_pace`

## iOS Configuration

iOS flavors require manual configuration in Xcode:

1. Open `ios/Runner.xcworkspace` in Xcode
2. Add new schemes for Dev and Prod
3. Configure build settings to use the appropriate Info.plist files:
   - Dev: `ios/Runner/Flavors/Dev/Info.plist`
   - Prod: `ios/Runner/Flavors/Prod/Info.plist`

## Flavor-Specific Code

The flavor configuration is handled in `lib/flavor_config.dart`. You can access the current flavor using:

```dart
if (FlavorConfig.isDevelopment()) {
  // Dev-specific code
} else if (FlavorConfig.isProduction()) {
  // Prod-specific code
}
```

## Welcome Module

The welcome module is only included in the production flavor. The development flavor skips the welcome screen entirely and goes directly to the home screen.

## Building for Release

### Android
```bash
# Dev release
flutter build apk --release --flavor dev --target lib/main_dev.dart

# Prod release
flutter build apk --release --flavor prod --target lib/main_prod.dart
```

### iOS
```bash
# Dev release
flutter build ios --release --flavor dev --target lib/main_dev.dart

# Prod release
flutter build ios --release --flavor prod --target lib/main_prod.dart
```

Note: iOS builds require proper code signing configuration in Xcode.
