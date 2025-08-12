import 'package:equatable/equatable.dart';

abstract class FocusTimerState extends Equatable {
  const FocusTimerState();

  @override
  List<Object?> get props => [];
}

class FocusTimerInitial extends FocusTimerState {
  const FocusTimerInitial();
}

class FocusTimerRunInProgress extends FocusTimerState {
  final int duration;

  const FocusTimerRunInProgress(this.duration);

  @override
  List<Object?> get props => [duration];
}

class FocusTimerPaused extends FocusTimerState {
  final int duration;

  const FocusTimerPaused(this.duration);

  @override
  List<Object?> get props => [duration];
}

class FocusTimerCompleted extends FocusTimerState {
  const FocusTimerCompleted();
}
