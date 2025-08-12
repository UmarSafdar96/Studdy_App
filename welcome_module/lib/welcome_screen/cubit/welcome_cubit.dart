// lib/src/features/screens/welcome_screen/bloc/welcome_state.dart
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../model/welcome_item.dart'; // Make sure this path is correct
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // For PageController
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final PageController pageController = PageController();

  WelcomeCubit() : super(const WelcomeState());

  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void nextPage() {
    if (state.currentIndex < state.welcomeItems.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (state.currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> getStarted(BuildContext context) async {
    final settingsBox = Hive.box('settings');
    await settingsBox.put('isFirstRun', false);
    
    // Use GetX navigation directly
    Get.offAllNamed('/home');
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}