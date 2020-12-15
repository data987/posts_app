class EnvironmentConfig {
  ///
  /// Url for service
  ///
  static const String API_URL = String.fromEnvironment('API_URL',
      defaultValue: "https://jsonplaceholder.typicode.com/");
}
