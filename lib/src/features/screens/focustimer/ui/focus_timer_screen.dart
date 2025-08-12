import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/focus_timer_bloc.dart';
import '../bloc/focus_timer_event.dart';
import '../bloc/focus_timer_state.dart';

class FocusTimerScreen extends StatelessWidget {
  const FocusTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Get.find<FocusTimerBloc>(),
      child: const FocusTimerView(),
    );
  }
}

class FocusTimerView extends StatelessWidget {
  const FocusTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<FocusTimerBloc, FocusTimerState>(
        builder: (context, state) {
          int currentDuration = FocusTimerBloc.focusDuration;
          if (state is FocusTimerRunInProgress) {
            currentDuration = state.duration;
          } else if (state is FocusTimerPaused) {
            currentDuration = state.duration;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer Display
                Container(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Progress Circle
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: CircularProgressIndicator(
                          value: state is FocusTimerRunInProgress || state is FocusTimerPaused
                              ? (currentDuration / FocusTimerBloc.focusDuration)
                              : 0.0,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      // Time Display
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _formatDuration(currentDuration),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _getStatusText(state),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is FocusTimerInitial)
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerStarted());
                        },
                        child: const Text('Start'),
                      ),
                    if (state is FocusTimerRunInProgress) ...[
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerPausedEvent());
                        },
                        child: const Text('Pause'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerReset());
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                    if (state is FocusTimerPaused) ...[
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerResumed());
                        },
                        child: const Text('Resume'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerReset());
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                    if (state is FocusTimerCompleted) ...[
                      ElevatedButton(
                        onPressed: () {
                          context.read<FocusTimerBloc>().add(const FocusTimerReset());
                        },
                        child: const Text('Restart'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getStatusText(FocusTimerState state) {
    if (state is FocusTimerInitial) return 'Ready to start';
    if (state is FocusTimerRunInProgress) return 'Focusing...';
    if (state is FocusTimerPaused) return 'Paused';
    if (state is FocusTimerCompleted) return 'Session completed!';
    return '';
  }
}
