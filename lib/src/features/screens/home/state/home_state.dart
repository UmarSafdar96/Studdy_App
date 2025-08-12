// lib/src/features/screens/home/bloc/home_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Color and IconData
import '../models/study_session.dart'; // Ensure this path is correct

class HomeState extends Equatable {
  final int todayStudyTimeMinutes; // in minutes
  final int weeklyGoalHours;       // in hours
  final int completedSessions;
  final int totalSessions;
  final String userName;
  final List<StudySession> upcomingSessions;
  final String currentStudySessionTitle; // To display if a session is active

  // Derived properties
  double get weeklyProgress => todayStudyTimeMinutes / (weeklyGoalHours * 60).toDouble();
  double get dailyProgress => completedSessions / totalSessions.toDouble();

  const HomeState({
    this.todayStudyTimeMinutes = 0,
    this.weeklyGoalHours = 20,
    this.completedSessions = 3,
    this.totalSessions = 6,
    this.userName = 'Juma',
    this.upcomingSessions = const [],
    this.currentStudySessionTitle = '',
  });

  // copyWith for easy state updates
  HomeState copyWith({
    int? todayStudyTimeMinutes,
    int? weeklyGoalHours,
    int? completedSessions,
    int? totalSessions,
    String? userName,
    List<StudySession>? upcomingSessions,
    String? currentStudySessionTitle,
  }) {
    return HomeState(
      todayStudyTimeMinutes: todayStudyTimeMinutes ?? this.todayStudyTimeMinutes,
      weeklyGoalHours: weeklyGoalHours ?? this.weeklyGoalHours,
      completedSessions: completedSessions ?? this.completedSessions,
      totalSessions: totalSessions ?? this.totalSessions,
      userName: userName ?? this.userName,
      upcomingSessions: upcomingSessions ?? this.upcomingSessions,
      currentStudySessionTitle: currentStudySessionTitle ?? this.currentStudySessionTitle,
    );
  }

  @override
  List<Object?> get props => [
    todayStudyTimeMinutes,
    weeklyGoalHours,
    completedSessions,
    totalSessions,
    userName,
    upcomingSessions,
    currentStudySessionTitle,
  ];
}

// Initial State for the Home screen
// This can be part of the HomeState file or a separate one.
// For simplicity, let's keep it in the cubit or directly in the initial state definition.