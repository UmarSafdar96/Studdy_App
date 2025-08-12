import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'focus_timer_event.dart';
import 'focus_timer_state.dart';

class FocusTimerBloc extends Bloc<FocusTimerEvent, FocusTimerState> {
  static const int focusDuration = 1500; // 25 minutes in seconds
  Timer? _ticker;
  final Dio dio;

  FocusTimerBloc(this.dio) : super(const FocusTimerInitial()) {
    on<FocusTimerStarted>(_onStarted);
    on<FocusTimerTicked>(_onTicked);
    on<FocusTimerPausedEvent>(_onPaused);
    on<FocusTimerResumed>(_onResumed);
    on<FocusTimerReset>(_onReset);
  }

  void _onStarted(FocusTimerStarted event, Emitter<FocusTimerState> emit) {
    emit(FocusTimerRunInProgress(focusDuration));
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const FocusTimerTicked());
    });
  }

  void _onTicked(FocusTimerTicked event, Emitter<FocusTimerState> emit) {
    if (state is FocusTimerRunInProgress) {
      final currentState = state as FocusTimerRunInProgress;
      final newDuration = currentState.duration - 1;
      
      if (newDuration > 0) {
        emit(FocusTimerRunInProgress(newDuration));
      } else {
        _ticker?.cancel();
        emit(const FocusTimerCompleted());
      }
    }
  }

  void _onPaused(FocusTimerPausedEvent event, Emitter<FocusTimerState> emit) {
    _ticker?.cancel();
    if (state is FocusTimerRunInProgress) {
      final currentState = state as FocusTimerRunInProgress;
      emit(FocusTimerPaused(currentState.duration));
    }
  }

  void _onResumed(FocusTimerResumed event, Emitter<FocusTimerState> emit) {
    if (state is FocusTimerPaused) {
      final currentState = state as FocusTimerPaused;
      emit(FocusTimerRunInProgress(currentState.duration));
      _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(const FocusTimerTicked());
      });
    }
  }

  void _onReset(FocusTimerReset event, Emitter<FocusTimerState> emit) {
    _ticker?.cancel();
    emit(const FocusTimerInitial());
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}


