// lib/src/features/screens/home/widgets/quick_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import '../cubit/home_cubit.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the cubit instance to call its methods
    final homeCubit = context.read<HomeCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Quick Focus',
                subtitle: '25 min session',
                icon: Icons.play_circle_filled,
                color: Colors.orange,
                // Call the cubit method, passing context for side effects like SnackBar/navigation
                onTap: () => homeCubit.startQuickSession(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                title: 'New Session',
                subtitle: 'Custom plan',
                icon: Icons.add_circle,
                color: Colors.blue,
                // Call the cubit method, passing context for navigation
                onTap: () => homeCubit.gotoPlanner(),
              ),
            ),
            const SizedBox(width: 12), // Uncomment if you want the third card
            // Expanded(
            //   child: _buildActionCard(
            //     title: 'Join Group',
            //     subtitle: 'Study together',
            //     icon: Icons.group,
            //     color: Colors.purple,
            //     // Call the cubit method, passing context for navigation
            //     onTap: () => homeCubit.gotoGroups(context),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/home_controller.dart';
//
// class QuickActions extends StatelessWidget {
//   const QuickActions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quick Actions',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildActionCard(
//                 title: 'Quick Focus',
//                 subtitle: '25 min session',
//                 icon: Icons.play_circle_filled,
//                 color: Colors.orange,
//                 onTap: controller.startQuickSession,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildActionCard(
//                 title: 'New Session',
//                 subtitle: 'Custom plan',
//                 icon: Icons.add_circle,
//                 color: Colors.blue,
//                 onTap: () => controller.gotoPlanner(),
//               ),
//             ),
//             // const SizedBox(width: 12),
//             // Expanded(
//             //   child: _buildActionCard(
//             //     title: 'Join Group',
//             //     subtitle: 'Study together',
//             //     icon: Icons.group,
//             //     color: Colors.purple,
//             //     onTap: () => controller.gotoGroups(),
//             //   ),
//             // ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionCard({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: color.withValues(alpha: 0.2)),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 32),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 12, color: color),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
