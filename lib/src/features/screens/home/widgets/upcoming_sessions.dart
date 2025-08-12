// lib/src/features/screens/home/widgets/upcoming_sessions.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../helpers/subject_icon_mapper.dart';
import '../../../../routing/navigation_service.dart';
import '../../schedule/bloc/planner_bloc.dart';
import '../../schedule/bloc/planner_state.dart';
import '../models/study_session.dart';

class UpcomingSessions extends StatelessWidget {
  const UpcomingSessions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(
      buildWhen: (previous, current) => previous != current, // Ensures rebuild on state changes
      builder: (context, state) {
        if (state is! PlannerLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final today = DateTime.now();
        final todayKey = DateTime(today.year, today.month, today.day);
        final todaySessions = state.weekSessions[todayKey] ?? [];

        if (todaySessions.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/no_data.json',
                  height: 200,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nothing in today\'s schedule',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        }

        final sessionModels = todaySessions.map((e) => StudySession(
          title: e.title,
          subject: e.subject,
          time: '${e.startTime} - ${e.endTime}',
          icon: getIconForSubject(e.subject),
          color: e.color,
        )).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Schedule',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.find<NavigationService>().navigateToSchedule(),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessionModels.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final session = sessionModels[index];
                return _buildSessionCard(session);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSessionCard(StudySession session) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: session.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(session.icon, color: session.color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  session.time,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: session.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              session.subject,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: session.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
// import '../cubit/home_cubit.dart';
// import '../models/study_session.dart';
// import '../state/home_state.dart';
//
// class UpcomingSessions extends StatelessWidget {
//   const UpcomingSessions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final homeCubit = context.read<HomeCubit>(); // Get the cubit instance
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Today\'s Schedule',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             TextButton(
//               onPressed: () => homeCubit.gotoPlanner(), // Call Cubit method for navigation
//               child: const Text('View All'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         // Use BlocBuilder to rebuild the ListView when upcomingSessions changes
//         BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             final upcomingSessions = state.upcomingSessions;
//             return ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: upcomingSessions.length,
//               separatorBuilder: (context, index) => const SizedBox(height: 12),
//               itemBuilder: (context, index) {
//                 final session = upcomingSessions[index];
//                 return _buildSessionCard(session);
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSessionCard(StudySession session) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: session.color.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(session.icon, color: session.color, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   session.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   session.time,
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: session.color.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               session.subject,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: session.color,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smart_pace/src/features/screens/schedule/schedulle_screen.dart';
//
// import '../controllers/home_controller.dart';
// import '../models/study_session.dart';
//
// class UpcomingSessions extends StatelessWidget {
//   const UpcomingSessions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Today\'s Schedule',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             TextButton(
//               onPressed: () => Get.to(PlannerScreen()),
//               child: const Text('View All'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Obx(
//               () => ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.upcomingSessions.length,
//             separatorBuilder: (context, index) => const SizedBox(height: 12),
//             itemBuilder: (context, index) {
//               final session = controller.upcomingSessions[index];
//               return _buildSessionCard(session);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSessionCard(StudySession session) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: session.color.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(session.icon, color: session.color, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   session.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   session.time,
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: session.color.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               session.subject,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: session.color,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
