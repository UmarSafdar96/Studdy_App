import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/focus_timer_bloc.dart';
import '../bloc/focus_timer_event.dart';
import '../bloc/focus_timer_state.dart';

// class TimerControls extends StatelessWidget {
//   final FocusTimerState state;
//
//   const TimerControls({super.key, required this.state});
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<FocusTimerBloc>();
//
//     if (state is FocusTimerInitial || state is TimerPaused) {
//       return ElevatedButton.icon(
//         icon: const Icon(Icons.play_arrow),
//         label: const Text('Start'),
//         onPressed: () => bloc.add(const StartTimer()),
//       );
//     } else if (state is TimerRunning) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton.icon(
//             icon: const Icon(Icons.pause),
//             label: const Text('Pause'),
//             onPressed: () => bloc.add(const PauseTimer()),
//           ),
//           const SizedBox(width: 20),
//           OutlinedButton.icon(
//             icon: const Icon(Icons.stop),
//             label: const Text('Reset'),
//             onPressed: () => bloc.add(const ResetTimer()),
//           ),
//         ],
//       );
//     } else if (state is TimerComplete) {
//       return ElevatedButton.icon(
//         icon: const Icon(Icons.refresh),
//         label: const Text('Restart'),
//         onPressed: () => bloc.add(const ResetTimer()),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
