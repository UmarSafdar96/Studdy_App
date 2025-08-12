import 'package:equatable/equatable.dart';

abstract class FocusTimerEvent extends Equatable {
  const FocusTimerEvent();

  @override
  List<Object?> get props => [];
}

class FocusTimerStarted extends FocusTimerEvent {
  const FocusTimerStarted();
}

class FocusTimerTicked extends FocusTimerEvent {
  const FocusTimerTicked();
}

class FocusTimerPausedEvent extends FocusTimerEvent {
  const FocusTimerPausedEvent();
}

class FocusTimerResumed extends FocusTimerEvent {
  const FocusTimerResumed();
}

class FocusTimerReset extends FocusTimerEvent {
  const FocusTimerReset();
}
