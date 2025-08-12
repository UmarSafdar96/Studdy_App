enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final bool showWelcomeScreen;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String appName,
    required bool showWelcomeScreen,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      appName: appName,
      showWelcomeScreen: showWelcomeScreen,
    );
    return _instance!;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.appName,
    required this.showWelcomeScreen,
  });

  static FlavorConfig get instance {
    return _instance ?? (throw Exception('FlavorConfig not initialized'));
  }

  static bool isProduction() => _instance?.flavor == Flavor.prod;
  static bool isDevelopment() => _instance?.flavor == Flavor.dev;
}
