
// lib/features/planner/presentation/widgets/week_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/planner_bloc.dart';
import '../bloc/planner_event.dart';
import '../bloc/planner_state.dart';
import 'day_selector.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({super.key});

  String getMonthYear(DateTime start, DateTime end) {
    final startFormat = DateFormat('MMM');
    final endFormat = DateFormat('MMM yyyy');
    if (start.month == end.month) {
      return '${startFormat.format(start)} ${end.year}';
    } else {
      return '${startFormat.format(start)} - ${endFormat.format(end)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        if (state is PlannerLoaded) {
          final weekDays = state.currentWeekDays;
          final monthYear = getMonthYear(weekDays.first, weekDays.last);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
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
              children: [
                // Month-Year Header with Arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PlannerBloc>(context)
                            .add(const NavigateWeekEvent(-1));
                      },
                      icon: const Icon(Icons.chevron_left, size: 28),
                      color: Colors.black54,
                    ),
                    Text(
                      monthYear,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PlannerBloc>(context)
                            .add(const NavigateWeekEvent(1));
                      },
                      icon: const Icon(Icons.chevron_right, size: 28),
                      color: Colors.black54,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Day Selector Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: weekDays.map((date) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: buildDaySelector(context, date),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox(); // Default fallback
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/planner_controller.dart';
// import '../models/days.dart';
// import 'day_selector.dart';
//
// class WeekSelector extends StatelessWidget {
//   const WeekSelector({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//             final PlannerController controller = Get.put(PlannerController());
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(16),
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
//       child: Obx(() {
//         final weekDays = controller.currentWeekDays;
//         final monthYear = getMonthYear(weekDays.first, weekDays.last);
//
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () => controller.navigateWeek(-1),
//                   icon: const Icon(Icons.chevron_left, size: 28),
//                   color: Colors.black54,
//                 ),
//                 Text(
//                   monthYear,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => controller.navigateWeek(1),
//                   icon: const Icon(Icons.chevron_right, size: 28),
//                   color: Colors.black54,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: weekDays.map((date) => buildDaySelector(date)).toList(),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }