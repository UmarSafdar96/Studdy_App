import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_router.dart';

class NavigationService extends GetxService {
  static NavigationService get to => Get.find();

  // Navigation methods
  void navigateToHome() {
    Get.offAllNamed(AppRouter.home);
  }

  void navigateToWelcome() {
    Get.offAllNamed(AppRouter.welcome);
  }

  void navigateToSchedule() {
    Get.toNamed(AppRouter.schedule);
  }

  void navigateToProfile() {
    Get.toNamed(AppRouter.profile);
  }

  void navigateToFocusTimer() {
    Get.toNamed(AppRouter.focusTimer);
  }

  // Replace current route
  void replaceWithHome() {
    Get.offNamed(AppRouter.home);
  }

  void replaceWithWelcome() {
    Get.offNamed(AppRouter.welcome);
  }

  // Go back
  void goBack() {
    Get.back();
  }

  // Go back to specific route
  void goBackTo(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  // Clear all routes and navigate
  void clearAndNavigate(String routeName) {
    Get.offAllNamed(routeName);
  }

  // Check if can go back
  bool get canGoBack => Navigator.of(Get.context!).canPop();

  // Get current route
  String? get currentRoute => Get.currentRoute;

  // Get previous route
  String? get previousRoute => Get.previousRoute;
}
