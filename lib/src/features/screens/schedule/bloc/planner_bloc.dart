// lib/features/planner/presentation/bloc/planner_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/study_session_entity.dart';
import '../repository/study_session_repository.dart';
import 'planner_event.dart';
import 'planner_state.dart';
import 'utils/date_utils.dart';


class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  final StudySessionRepository _repository;

  PlannerBloc(this._repository) : super(
    PlannerLoaded(
      weekSessions: {},
      selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), // Ensure normalized date
      currentWeekOffset: 0,
    ),
  ) {
    on<LoadSessions>(_onLoadSessions);
    on<AddSessionEvent>(_onAddSession);
    on<UpdateSessionEvent>(_onUpdateSession);
    on<DeleteSessionEvent>(_onDeleteSession);
    on<SelectDateEvent>(_onSelectDate);
    on<NavigateWeekEvent>(_onNavigateWeek);
  }

  Future<void> _onLoadSessions(
      LoadSessions event, Emitter<PlannerState> emit) async {
    // Only show loading if not already in a loading state or if data is empty
    if (state is! PlannerLoading && (state is PlannerLoaded && (state as PlannerLoaded).weekSessions.isEmpty)) {
      emit(const PlannerLoading());
    }
    try {
      final sessions = await _repository.getSessions();
      final Map<DateTime, List<StudySessionEntity>> weekSessions = {};
      for (var session in sessions) {
        final dateKey = DateTime(session.sessionDate.year, session.sessionDate.month, session.sessionDate.day);
        if (!weekSessions.containsKey(dateKey)) {
          weekSessions[dateKey] = [];
        }
        weekSessions[dateKey]!.add(session);
      }
      if (state is PlannerLoaded) {
        final loadedState = state as PlannerLoaded;
        emit(loadedState.copyWith(weekSessions: weekSessions));
      } else {
        emit(
          PlannerLoaded(
            weekSessions: weekSessions,
            selectedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            currentWeekOffset: 0,
          ),
        );
      }
    } catch (e) {
      emit(PlannerError('Failed to load sessions: ${e.toString()}'));
    }
  }

  Future<void> _onAddSession(
      AddSessionEvent event, Emitter<PlannerState> emit) async {
    if (state is PlannerLoaded) {
      final loadedState = state as PlannerLoaded;
      try {
        await _repository.addSession(event.session);
        add(const LoadSessions());
        final updatedSessions = Map<DateTime, List<StudySessionEntity>>.from(loadedState.weekSessions);
        final dateKey = DateTime(event.session.sessionDate.year, event.session.sessionDate.month, event.session.sessionDate.day);

        if (!updatedSessions.containsKey(dateKey)) {
          updatedSessions[dateKey] = [];
        }
        updatedSessions[dateKey]!.add(event.session);
        emit(loadedState.copyWith(weekSessions: updatedSessions));
      } catch (e) {
        emit(PlannerError('Failed to add session: ${e.toString()}'));
      }
    }
  }

  Future<void> _onUpdateSession(
      UpdateSessionEvent event, Emitter<PlannerState> emit) async {
    if (state is PlannerLoaded) {
      final loadedState = state as PlannerLoaded;
      try {
        await _repository.updateSession(event.session);
        add(const LoadSessions());
        final updatedSessions = Map<DateTime, List<StudySessionEntity>>.from(loadedState.weekSessions);
        final oldSessionDateKey = DateTime(event.session.sessionDate.year, event.session.sessionDate.month, event.session.sessionDate.day); // Assuming session date doesn't change on edit, or handle moving sessions between dates

        // Remove from old date if date changed or if it's the same date but we're re-adding
        updatedSessions.forEach((dateKey, sessions) {
          sessions.removeWhere((s) => s.id == event.session.id);
        });
        // Clean up empty date keys
        updatedSessions.removeWhere((key, value) => value.isEmpty);


        // Add/update in new date
        if (!updatedSessions.containsKey(oldSessionDateKey)) {
          updatedSessions[oldSessionDateKey] = [];
        }
        updatedSessions[oldSessionDateKey]!.add(event.session);


        emit(loadedState.copyWith(weekSessions: updatedSessions));
      } catch (e) {
        emit(PlannerError('Failed to update session: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteSession(
      DeleteSessionEvent event, Emitter<PlannerState> emit) async {
    if (state is PlannerLoaded) {
      try {
        await _repository.deleteSession(event.sessionId);

        // After deletion, reload fresh data
        add(const LoadSessions());
      } catch (e) {
        emit(PlannerError('Failed to delete session: ${e.toString()}'));
      }
    }
  }

  void _onSelectDate(SelectDateEvent event, Emitter<PlannerState> emit) {
    if (state is PlannerLoaded) {
      final loadedState = state as PlannerLoaded;
      final normalizedDate = DateTime(event.date.year, event.date.month, event.date.day);
      emit(loadedState.copyWith(selectedDate: normalizedDate));
    }
  }

  void _onNavigateWeek(NavigateWeekEvent event, Emitter<PlannerState> emit) {
    if (state is PlannerLoaded) {
      final loadedState = state as PlannerLoaded;
      final newOffset = loadedState.currentWeekOffset + event.direction;

      // Calculate the start of the new week based on the new offset
      final newWeekStartDate = loadedState.getWeekStartDate(newOffset);

      // Determine the new selected date.
      // If the currently selected date is within the *old* week,
      // try to keep the same day of the week in the *new* week.
      // Otherwise, default to the first day of the new week.
      DateTime newSelectedDate;
      final oldWeekStartDate = loadedState.getWeekStartDate(loadedState.currentWeekOffset);
      if (loadedState.selectedDate.isAfter(oldWeekStartDate.subtract(const Duration(days: 1))) &&
          loadedState.selectedDate.isBefore(oldWeekStartDate.add(const Duration(days: 7)))) {
        // Current selected date is within the old week, keep its weekday in the new week
        newSelectedDate = newWeekStartDate.add(Duration(days: loadedState.selectedDate.weekday - 1));
      } else {
        // Default to the first day of the new week (Monday)
        newSelectedDate = newWeekStartDate;
      }

      emit(loadedState.copyWith(
        currentWeekOffset: newOffset,
        selectedDate: newSelectedDate,
      ));
    }
  }
}