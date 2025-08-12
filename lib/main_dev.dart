import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_pace/flavor_config.dart';
import 'package:smart_pace/src/features/screens/focustimer/bloc/focus_timer_bloc.dart';
import 'package:smart_pace/src/features/screens/focustimer/focus_timer_binding.dart';
import 'package:smart_pace/src/features/screens/focustimer/ui/focus_timer_screen.dart';
import 'package:smart_pace/src/features/screens/home/home.dart';
import 'package:smart_pace/src/features/screens/schedule/models/study_session_hive_model.dart';
import 'package:smart_pace/src/features/screens/schedule/schedulle_screen.dart';
import 'package:smart_pace/src/injection_container.dart';
import 'package:smart_pace/src/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor config for development
  FlavorConfig(
    flavor: Flavor.dev,
    appName: 'SmartPace Dev',
    showWelcomeScreen: false,
  );

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(StudySessionHiveModelAdapter());

  final dio = Dio();
  final cookieJar = CookieJar();

  dio.interceptors.add(CookieManager(cookieJar));

  // Register BLoC via GetX
  Get.put(FocusTimerBloc(dio));

  // Open Hive boxes
  await Hive.openBox<StudySessionHiveModel>('studySessions');
  await Hive.openBox('settings');

  // Initialize dependencies
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true, // Show debug banner for dev
      title: FlavorConfig.instance.appName,
      initialRoute: AppRouter.home, // Skip welcome screen in dev
      getPages: [
        GetPage(name: AppRouter.home, page: () => const HomeScreen()),
        GetPage(name: AppRouter.schedule, page: () => const PlannerScreen()),

        // Focus Timer Route
        GetPage(
          name: AppRouter.focusTimer,
          page: () => BlocProvider(
            create: (_) => Get.find<FocusTimerBloc>(),
            child: const FocusTimerScreen(),
          ),
          binding: FocusTimerBinding(),
        ),
      ],
    );
  }
}
