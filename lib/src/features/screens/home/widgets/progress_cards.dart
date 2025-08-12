
// lib/src/features/screens/home/widgets/progress_cards.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import '../cubit/home_cubit.dart';
import '../state/home_state.dart';

class ProgressCards extends StatelessWidget {
  ProgressCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to react to HomeState changes
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Access data from the current state
        final todayStudyTime = state.todayStudyTimeMinutes;
        final weeklyGoal = state.weeklyGoalHours;
        final dailyProgress = state.dailyProgress;
        final weeklyProgress = state.weeklyProgress;

        return Row(
          children: [
            Expanded(
              child: _buildProgressCard(
                title: 'Today\'s Focus',
                value: '${(todayStudyTime / 60).toStringAsFixed(1)}h',
                progress: dailyProgress, // Use dailyProgress from state
                color: Colors.blue,
                icon: Icons.timer_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildProgressCard(
                title: 'Weekly Goal',
                value: '${weeklyGoal}h',
                progress: weeklyProgress, // Use weeklyProgress from state
                color: Colors.green,
                icon: Icons.flag_outlined,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String value,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/home_controller.dart';
//
// class ProgressCards extends StatelessWidget {
//   ProgressCards({super.key});
//
//   final HomeController controller = Get.put(HomeController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(()=> Row(
//       children: [
//         Expanded(
//           child: _buildProgressCard(
//             title: 'Today\'s Focus',
//             value: '${(controller.todayStudyTime.value / 60).toStringAsFixed(1)}h',
//             progress: controller.dailyProgress,
//             color: Colors.blue,
//             icon: Icons.timer_outlined,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _buildProgressCard(
//             title: 'Weekly Goal',
//             value: '${controller.weeklyGoal.value}h',
//             progress: controller.weeklyProgress,
//             color: Colors.green,
//             icon: Icons.flag_outlined,
//           ),
//         ),
//       ],
//     ));
//
//   }
//   Widget _buildProgressCard({
//     required String title,
//     required String value,
//     required double progress,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(icon, color: color, size: 24),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           LinearProgressIndicator(
//             value: progress.clamp(0.0, 1.0),
//             backgroundColor: color.withValues(alpha: 0.1),
//             valueColor: AlwaysStoppedAnimation<Color>(color),
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ],
//       ),
//     );
//   }
// }
