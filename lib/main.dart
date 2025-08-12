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
import 'package:smart_pace/src/features/screens/profile/profile.dart';
import 'package:smart_pace/src/features/screens/schedule/models/study_session_hive_model.dart';
import 'package:smart_pace/src/features/screens/schedule/schedulle_screen.dart';
import 'package:smart_pace/src/injection_container.dart';
import 'package:smart_pace/src/routing/app_router.dart';
import 'package:welcome_module/welcome_module.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Detect flavor from command line arguments
  bool isDevFlavor = args.contains('--flavor') && args.contains('dev');

  // Initialize flavor config based on detected flavor
  if (isDevFlavor) {
    FlavorConfig(
      flavor: Flavor.dev,
      appName: 'SmartPace Dev',
      showWelcomeScreen: false,
    );
  } else {
    FlavorConfig(
      flavor: Flavor.prod,
      appName: 'SmartPace',
      showWelcomeScreen: true,
    );
  }

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
  var settingsBox = await Hive.openBox('settings');

  // Check if it's first run (only for prod flavor)
  bool isFirstRun = false;
  if (!isDevFlavor) {
    isFirstRun = settingsBox.get('isFirstRun', defaultValue: true);
  }

  // Initialize dependencies
  await initDependencies();

  runApp(MyApp(isFirstRun: isFirstRun, isDevFlavor: isDevFlavor));
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  final bool isDevFlavor;

  const MyApp({super.key, required this.isFirstRun, required this.isDevFlavor});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: isDevFlavor, // Show debug banner only for dev
      title: FlavorConfig.instance.appName,
      initialRoute: isDevFlavor ? AppRouter.home : (isFirstRun ? AppRouter.welcome : AppRouter.home),
      getPages: [
        // Welcome route (only for prod flavor)
        if (!isDevFlavor)
          GetPage(
            name: AppRouter.welcome,
            page: () => const WelcomeScreen(),
            binding: BindingsBuilder(() {
              // Welcome screen dependencies are handled by the module
            }),
          ),
        GetPage(name: AppRouter.home, page: () => const HomeScreen()),
        GetPage(name: AppRouter.schedule, page: () => const PlannerScreen()),
        GetPage(name: AppRouter.profile, page: () => const ProfileScreen()),

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

