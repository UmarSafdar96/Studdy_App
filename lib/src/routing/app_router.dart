import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/screens/focustimer/ui/focus_timer_screen.dart';
import '../features/screens/home/home.dart';
import '../features/screens/profile/profile.dart';
import '../features/screens/schedule/schedulle_screen.dart';
import '../injection_container.dart';
import 'package:welcome_module/welcome_module.dart';

class AppRouter {
  static const String home = '/home';
  static const String welcome = '/welcome';
  static const String schedule = '/schedule';
  static const String profile = '/profile';
  static const String focusTimer = '/focus-timer';

  static final GetPage<dynamic> homeRoute = GetPage(
    name: home,
    page: () => const HomeScreen(),
    binding: BindingsBuilder(() {
      // Inject any dependencies needed for HomeScreen
    }),
  );

  static final GetPage<dynamic> welcomeRoute = GetPage(
    name: welcome,
    page: () => const WelcomeScreen(),
    binding: BindingsBuilder(() {
      // Welcome screen dependencies will be injected by the module
    }),
  );

  static final GetPage<dynamic> scheduleRoute = GetPage(
    name: schedule,
    page: () => const PlannerScreen(),
    binding: BindingsBuilder(() {
      // Schedule dependencies are already injected in initDependencies
    }),
  );

  static final GetPage<dynamic> profileRoute = GetPage(
    name: profile,
    page: () => const ProfileScreen(),
    binding: BindingsBuilder(() {
      // Profile dependencies
    }),
  );

  static final GetPage<dynamic> focusTimerRoute = GetPage(
    name: focusTimer,
    page: () => const FocusTimerScreen(),
    binding: BindingsBuilder(() {
      // Focus timer dependencies are already injected
    }),
  );

  static List<GetPage<dynamic>> get routes => [
    homeRoute,
    welcomeRoute,
    scheduleRoute,
    profileRoute,
    focusTimerRoute,
  ];
}
