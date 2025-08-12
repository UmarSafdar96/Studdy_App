# SmartPace Routing System with Dependency Injection

This document explains the new routing system implemented in SmartPace that uses global dependency injection to eliminate the need for custom code blocks in navigation.

## Overview

The new routing system consists of three main components:

1. **AppRouter** - Defines all routes and their bindings
2. **NavigationService** - Provides navigation methods
3. **Dependency Injection** - Manages all dependencies globally

## Architecture

### 1. AppRouter (`lib/src/routing/app_router.dart`)

The `AppRouter` class defines all application routes with their respective bindings:

```dart
class AppRouter {
  static const String home = '/home';
  static const String welcome = '/welcome';
  static const String schedule = '/schedule';
  // ... more routes

  static final GetPage<dynamic> homeRoute = GetPage(
    name: home,
    page: () => const HomeScreen(),
    binding: BindingsBuilder(() {
      // Inject dependencies for HomeScreen
    }),
  );
}
```

### 2. NavigationService (`lib/src/routing/navigation_service.dart`)

The `NavigationService` provides centralized navigation methods:

```dart
class NavigationService extends GetxService {
  static NavigationService get to => Get.find();

  void navigateToHome() {
    Get.offAllNamed(AppRouter.home);
  }

  void navigateToSchedule() {
    Get.toNamed(AppRouter.schedule);
  }

  // ... more navigation methods
}
```

### 3. Dependency Injection (`lib/src/injection_container.dart`)

All dependencies are managed globally:

```dart
Future<void> initDependencies() async {
  // Initialize Navigation Service
  Get.put<NavigationService>(NavigationService());

  // Controllers
  Get.lazyPut<HomeController>(() => HomeController());
  Get.lazyPut<ProfileController>(() => ProfileController());
  // ... more dependencies
}
```

## Usage Examples

### Before (Old Approach)

```dart
// Welcome screen with callback
class WelcomeScreen extends StatefulWidget {
  final VoidCallback onFinished;
  
  const WelcomeScreen({required this.onFinished});
}

// Usage in main.dart
GetPage(
  name: '/welcome',
  page: () => WelcomeScreen(
    onFinished: () {
      Get.offAllNamed('/home');
    },
  ),
),

// Direct navigation in components
Get.toNamed('/focus');
Get.to(PlannerScreen());
```

### After (New Approach)

```dart
// Welcome screen without callback
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
}

// Welcome cubit using navigation service
class WelcomeCubit extends Cubit<WelcomeState> {
  final NavigationService _navigationService = Get.find<NavigationService>();

  Future<void> getStarted(BuildContext context) async {
    final settingsBox = Hive.box('settings');
    await settingsBox.put('isFirstRun', false);
    
    // Use navigation service instead of callback
    _navigationService.navigateToHome();
  }
}

// Usage in main.dart
GetPage(
  name: AppRouter.welcome,
  page: () => const WelcomeScreen(),
  binding: BindingsBuilder(() {
    // Dependencies handled by injection container
  }),
),

// Navigation in components using service
class HomeCubit extends Cubit<HomeState> {
  final NavigationService _navigationService = Get.find<NavigationService>();

  void startQuickSession() {
    _navigationService.navigateToFocusTimer();
  }

  void gotoPlanner() {
    _navigationService.navigateToSchedule();
  }
}
```

## Benefits

### 1. **Cleaner Code**
- No more callback parameters in widgets
- No more direct `Get.to()` calls scattered throughout the codebase
- Centralized navigation logic

### 2. **Better Testability**
- Navigation logic can be easily mocked
- Dependencies are injected, making testing easier
- Clear separation of concerns

### 3. **Maintainability**
- All routes defined in one place
- Easy to modify navigation behavior globally
- Consistent navigation patterns

### 4. **Modularity**
- Welcome module no longer needs to know about main app navigation
- Each module can use the navigation service independently
- Clear boundaries between modules

## Migration Guide

### Step 1: Update Dependencies
Ensure all controllers and services are registered in `injection_container.dart`:

```dart
// Add to initDependencies()
Get.lazyPut<YourController>(() => YourController());
```

### Step 2: Update Components
Replace direct navigation calls with navigation service:

```dart
// Before
Get.toNamed('/some-route');

// After
final navigationService = Get.find<NavigationService>();
navigationService.navigateToSomeRoute();
```

### Step 3: Remove Callbacks
Remove callback parameters from widgets and use navigation service instead:

```dart
// Before
class MyWidget extends StatelessWidget {
  final VoidCallback onFinished;
  
  const MyWidget({required this.onFinished});
}

// After
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
}
```

### Step 4: Update Route Definitions
Use `AppRouter` constants instead of hardcoded strings:

```dart
// Before
GetPage(name: '/home', page: () => HomeScreen()),

// After
GetPage(name: AppRouter.home, page: () => const HomeScreen()),
```

## Available Navigation Methods

The `NavigationService` provides the following methods:

### Basic Navigation
- `navigateToHome()` - Navigate to home screen
- `navigateToWelcome()` - Navigate to welcome screen
- `navigateToSchedule()` - Navigate to schedule screen
- `navigateToChat()` - Navigate to chat screen
- `navigateToGroups()` - Navigate to groups screen
- `navigateToProfile()` - Navigate to profile screen
- `navigateToFocusTimer()` - Navigate to focus timer screen

### Navigation with Data
- `navigateToChatDetail(dynamic chat)` - Navigate to chat detail with data
- `navigateToGroupDetail(dynamic group)` - Navigate to group detail with data

### Route Management
- `replaceWithHome()` - Replace current route with home
- `replaceWithWelcome()` - Replace current route with welcome
- `goBack()` - Go back to previous screen
- `goBackTo(String routeName)` - Go back to specific route
- `clearAndNavigate(String routeName)` - Clear all routes and navigate

### Route Information
- `canGoBack` - Check if can go back
- `currentRoute` - Get current route name
- `previousRoute` - Get previous route name

## Best Practices

1. **Always use the NavigationService** instead of direct GetX navigation calls
2. **Use AppRouter constants** instead of hardcoded route strings
3. **Register all dependencies** in the injection container
4. **Keep navigation logic in services** rather than in UI components
5. **Use proper route bindings** for dependency injection

## Example: Adding a New Route

1. **Add route constant to AppRouter:**
```dart
class AppRouter {
  static const String newFeature = '/new-feature';
  
  static final GetPage<dynamic> newFeatureRoute = GetPage(
    name: newFeature,
    page: () => const NewFeatureScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => NewFeatureController());
    }),
  );
}
```

2. **Add navigation method to NavigationService:**
```dart
class NavigationService extends GetxService {
  void navigateToNewFeature() {
    Get.toNamed(AppRouter.newFeature);
  }
}
```

3. **Register dependencies in injection container:**
```dart
Future<void> initDependencies() async {
  Get.lazyPut<NewFeatureController>(() => NewFeatureController());
}
```

4. **Use in components:**
```dart
class SomeCubit extends Cubit<SomeState> {
  final NavigationService _navigationService = Get.find<NavigationService>();

  void openNewFeature() {
    _navigationService.navigateToNewFeature();
  }
}
```

This new routing system provides a clean, maintainable, and testable approach to navigation in the SmartPace application.
