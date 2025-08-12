// lib/src/features/screens/home/bloc/home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // For Color and IconData
import 'package:get/get.dart';
import 'package:smart_pace/src/routing/navigation_service.dart';
import '../models/study_session.dart';
import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NavigationService _navigationService = Get.find<NavigationService>();

  HomeCubit() : super(_initialState());

  static HomeState _initialState() {
    return HomeState(
      todayStudyTimeMinutes: 90,
      weeklyGoalHours: 20,
      completedSessions: 3,
      totalSessions: 6,
      userName: 'Juma',
      upcomingSessions: [],
      currentStudySessionTitle: '',
    );
  }

  void startQuickSession() {
    // Use Get.snackbar directly here
    Get.snackbar(
      'Quick Session Started',
      'Your 25-minute focus session has begun!',
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
      snackPosition: SnackPosition.TOP, // This will give you the top position
    );

    // Use navigation service instead of direct Get.to
    _navigationService.navigateToFocusTimer();
  }

  void gotoPlanner() {
    // Use navigation service instead of direct Get.to
    _navigationService.navigateToSchedule();
  }

  void updateStudyProgress(int minutesStudied, int sessionsCompleted) {
    emit(state.copyWith(
      todayStudyTimeMinutes: state.todayStudyTimeMinutes + minutesStudied,
      completedSessions: state.completedSessions + sessionsCompleted,
    ));
  }

  void setWeeklyGoal(int newGoalHours) {
    emit(state.copyWith(weeklyGoalHours: newGoalHours));
  }

  void updateUserName(String newName) {
    emit(state.copyWith(userName: newName));
  }
}