// lib/features/planner/presentation/bloc/planner_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/study_session_entity.dart';


abstract class PlannerState extends Equatable {
  const PlannerState();

  @override
  List<Object> get props => [];
}

class PlannerLoading extends PlannerState {
  const PlannerLoading();
}

class PlannerLoaded extends PlannerState {
  final Map<DateTime, List<StudySessionEntity>> weekSessions;
  final DateTime selectedDate;
  final int currentWeekOffset;

  const PlannerLoaded({
    required this.weekSessions,
    required this.selectedDate,
    required this.currentWeekOffset,
  });

  List<StudySessionEntity> getSessionsForDate(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    return weekSessions[dateKey] ?? [];
  }

  DateTime getWeekStartDate(int offset) {
    final now = DateTime.now();
    // Get the start of the current week (Monday)
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    // Apply the offset for previous/next weeks, and normalize to start of day
    return DateTime(weekStart.year, weekStart.month, weekStart.day)
        .add(Duration(days: offset * 7));
  }

  List<DateTime> get currentWeekDays {
    final weekStartDate = getWeekStartDate(currentWeekOffset);
    return List.generate(7, (index) =>
        weekStartDate.add(Duration(days: index))
    );
  }

  @override
  List<Object> get props => [weekSessions, selectedDate, currentWeekOffset];

  PlannerLoaded copyWith({
    Map<DateTime, List<StudySessionEntity>>? weekSessions,
    DateTime? selectedDate,
    int? currentWeekOffset,
  }) {
    return PlannerLoaded(
      weekSessions: weekSessions ?? this.weekSessions,
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeekOffset: currentWeekOffset ?? this.currentWeekOffset,
    );
  }
}

class PlannerError extends PlannerState {
  final String message;
  const PlannerError(this.message);

  @override
  List<Object> get props => [message];
}