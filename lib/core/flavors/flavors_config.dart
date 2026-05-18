class FlavorConfig {
  static late FlavorConfig instance;

  final String flavor;
  final String baseUrl;

  const FlavorConfig({required this.flavor, required this.baseUrl});

  bool get isDev => flavor == 'dev';
  bool get isProd => flavor == 'prod';
}
