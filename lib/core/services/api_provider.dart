import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'http_requests.dart';

class ApiProvider {
  http.Client httpClient;
  HttpRequests _httpRequest = HttpRequests();

  ApiProvider({@required this.httpClient});
}
