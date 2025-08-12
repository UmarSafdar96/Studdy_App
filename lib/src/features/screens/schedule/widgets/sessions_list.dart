// lib/features/planner/presentation/widgets/sessions_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/planner_bloc.dart';
import '../bloc/planner_state.dart';
import 'session_card.dart';

class SessionsList extends StatelessWidget {
  const SessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        if (state is PlannerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlannerLoaded) {
          final sessions = state.getSessionsForDate(state.selectedDate);

          if (sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_note_outlined,
                    size: 64,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No sessions planned',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add a study session',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: sessions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final session = sessions[index];
              return sessionCard(context, session);
            },
          );
        } else if (state is PlannerError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container(); // Default empty container
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/planner_controller.dart';
// import 'session_card.dart';
//
// class SessionsList extends StatelessWidget {
//   const SessionsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//             final PlannerController controller = Get.put(PlannerController());
//
//       final sessions = controller.getSessionsForDate(controller.selectedDate.value);
//
//       if (sessions.isEmpty) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.event_note_outlined,
//                 size: 64,
//                 color: Colors.grey.shade300,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'No sessions planned',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey.shade500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Tap the + button to add a study session',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey.shade400,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//
//       return ListView.separated(
//         padding: const EdgeInsets.all(20),
//         itemCount: sessions.length,
//         separatorBuilder: (context, index) => const SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final session = sessions[index];
//           return sessionCard(session);
//         },
//       );
//     });
//   }
// }