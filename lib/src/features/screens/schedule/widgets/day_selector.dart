// lib/features/planner/presentation/widgets/day_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/planner_bloc.dart';
import '../bloc/planner_event.dart';
import '../bloc/planner_state.dart';
import '../bloc/utils/date_utils.dart';

Widget buildDaySelector(BuildContext context, DateTime date) {
  return BlocBuilder<PlannerBloc, PlannerState>(
    builder: (context, state) {
      if (state is PlannerLoaded) {
        final isSelected = isSameDay(date, state.selectedDate);
        final isToday = isSameDay(date, DateTime.now());
        final sessionsCount = state.getSessionsForDate(date).length;

        return GestureDetector(
          onTap: () => BlocProvider.of<PlannerBloc>(context).add(SelectDateEvent(date)),
          child: Container(
            width: 45,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: isToday && !isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getDayName(date.weekday),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                if (sessionsCount > 0)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      }
      return Container(); // Or a loading indicator
    },
  );
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smart_pace/src/features/screens/schedule/controller/planner_controller.dart';
//
// import '../models/days.dart';
//
// Widget buildDaySelector(DateTime date) {
//   final PlannerController controller = Get.put(PlannerController());
//
//   return Obx(() {
//     final isSelected = isSameDay(date, controller.selectedDate.value);
//     final isToday = isSameDay(date, DateTime.now());
//     final sessionsCount = controller.getSessionsForDate(date).length;
//
//     return GestureDetector(
//       onTap: () => controller.selectDate(date),
//       child: Container(
//         width: 45,
//         height: 70,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//           border:
//               isToday && !isSelected
//                   ? Border.all(color: Colors.blue, width: 2)
//                   : null,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               getDayName(date.weekday),
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white : Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               date.day.toString(),
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 2),
//             if (sessionsCount > 0)
//               Container(
//                 width: 6,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.white : Colors.blue,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   });
// }


/*void showAddSessionDialog(BuildContext context) {
    showSessionDialog(context, null);
  } */

  
