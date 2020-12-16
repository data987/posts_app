class EnvironmentConfig {
  ///
  /// Url for service
  ///
  static const String API_URL = String.fromEnvironment('API_URL',
      defaultValue: "https://jsonplaceholder.typicode.com");
}

class ApiEndpoints {
  ///
  /// Get posts
  ///
  /// @deprecated [baseUrl]: Base of endpoint, only for dev or temporal cases
  ///
  static String posts({@deprecated baseUrl}) {
    if (baseUrl == null) baseUrl = EnvironmentConfig.API_URL;
    return "$baseUrl/posts";
  }

  ///
  /// Get comments
  ///
  /// @deprecated [baseUrl]: Base of endpoint, only for dev or temporal cases
  ///
  static String comments({@deprecated baseUrl}) {
    if (baseUrl == null) baseUrl = EnvironmentConfig.API_URL;
    return "$baseUrl/comments";
  }
}
