
// lib/src/features/screens/home/home.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../schedule/bloc/planner_bloc.dart';
import '../schedule/bloc/planner_event.dart';
import 'cubit/home_cubit.dart';
import 'widgets/build_header.dart';
import 'widgets/progress_cards.dart';
import 'widgets/quick_actions.dart';
import 'widgets/study_streak.dart';
import 'widgets/upcoming_sessions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Delay until after first frame to access context safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final plannerBloc = Get.find<PlannerBloc>();
      plannerBloc.add(const LoadSessions()); // trigger session load
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider.value(value: Get.find<PlannerBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(),
                const SizedBox(height: 24),
                ProgressCards(),
                const SizedBox(height: 24),
                const QuickActions(),
                const SizedBox(height: 24),
                const UpcomingSessions(),
                const SizedBox(height: 24),
                const StudyStreak(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
