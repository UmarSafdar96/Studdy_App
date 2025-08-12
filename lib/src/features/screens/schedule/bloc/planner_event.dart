// lib/features/planner/presentation/bloc/planner_event.dart
import 'package:equatable/equatable.dart';

import '../models/study_session_entity.dart';

abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class LoadSessions extends PlannerEvent {
  const LoadSessions();
}

class AddSessionEvent extends PlannerEvent {
  final StudySessionEntity session;
  const AddSessionEvent(this.session);

  @override
  List<Object> get props => [session];
}

class UpdateSessionEvent extends PlannerEvent {
  final StudySessionEntity session;
  const UpdateSessionEvent(this.session);

  @override
  List<Object> get props => [session];
}

class DeleteSessionEvent extends PlannerEvent {
  final String sessionId;
  const DeleteSessionEvent(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}

class SelectDateEvent extends PlannerEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class NavigateWeekEvent extends PlannerEvent {
  final int direction; // 1 for next week, -1 for previous
  const NavigateWeekEvent(this.direction);

  @override
  List<Object> get props => [direction];
}