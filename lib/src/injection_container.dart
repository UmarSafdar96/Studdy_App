// lib/injection_container.dart
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/screens/focustimer/bloc/focus_timer_bloc.dart';
import 'features/screens/schedule/bloc/planner_bloc.dart';
import 'features/screens/schedule/models/study_session_hive_model.dart';
import 'features/screens/schedule/models/study_session_local_datasource.dart';
import 'features/screens/schedule/repository/study_session_repository.dart';
import 'features/screens/schedule/repository/study_session_repository_impl.dart';
import 'routing/navigation_service.dart';

Future<void> initDependencies() async {
  // Initialize Navigation Service
  Get.put<NavigationService>(NavigationService());

  // Hive Box
  final sessionBox = Hive.box<StudySessionHiveModel>('studySessions');
  Get.lazyPut<Box<StudySessionHiveModel>>(() => sessionBox, tag: 'sessionBox');

  // Data sources
  Get.lazyPut<StudySessionLocalDataSource>(
        () => StudySessionLocalDataSourceImpl(Get.find(tag: 'sessionBox')),
  );

  // Repositories
  Get.lazyPut<StudySessionRepository>(
        () => StudySessionRepositoryImpl(Get.find()),
  );

  // Blocs
  Get.put<PlannerBloc>(PlannerBloc(Get.find()));

  // Focus Timer Bloc (already initialized in main.dart)
  // Get.put<FocusTimerBloc>(FocusTimerBloc(Get.find<Dio>()));
}