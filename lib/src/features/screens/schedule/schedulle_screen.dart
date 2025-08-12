// lib/features/planner/presentation/pages/planner_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_pace/src/features/screens/schedule/widgets/header.dart';
import 'package:smart_pace/src/features/screens/schedule/widgets/session_dialog.dart';
import 'package:smart_pace/src/features/screens/schedule/widgets/week_selector.dart';
import 'package:smart_pace/src/features/screens/schedule/widgets/weekly_view.dart';
import 'bloc/planner_bloc.dart';
import 'bloc/planner_event.dart';
import 'bloc/planner_state.dart'; // Import Get for dependency injection

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlannerBloc>.value(
      value: Get.find<PlannerBloc>(), // GetX still used for injection
      child: const PlannerView(),
    );
  }
}

class PlannerView extends StatefulWidget {
  const PlannerView({super.key});

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  @override
  void initState() {
    super.initState();
    context.read<PlannerBloc>().add(const LoadSessions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: BlocBuilder<PlannerBloc, PlannerState>(
          builder: (context, state) {
            if (state is PlannerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlannerLoaded) {
              return Column(
                children: [
                  const SchedulleHeader(),
                  WeekSelector(), // uses PlannerLoaded internally
                  const Expanded(child: WeeklyView()),
                ],
              );
            } else if (state is PlannerError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox(); // Fallback
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddSessionDialog(context),
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Session',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void showAddSessionDialog(BuildContext context) {
    showSessionDialog(context, null);
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controller/planner_controller.dart';
//
// import 'widgets/header.dart';
// import 'widgets/session_dialog.dart';
// import 'widgets/week_selector.dart';
// import 'widgets/weekly_view.dart';
//
// class PlannerScreen extends StatelessWidget {
//   final PlannerController controller = Get.put(PlannerController());
//
//   PlannerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       body: SafeArea(
//         child: Column(
//           children: [
//             SchedulleHeader(),
//             WeekSelector(),
//             Expanded(child: WeeklyView()),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => showAddSessionDialog(context),
//         backgroundColor: Colors.blue,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text(
//           'Add Session',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   void showAddSessionDialog(BuildContext context) {
//     showSessionDialog(context, null);
//   }
// }
