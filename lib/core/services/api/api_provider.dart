import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zemoga_posts/environment_config.dart';

import 'http_requests.dart';

class ApiProvider {
  http.Client httpClient;
  HttpRequests _httpRequest = HttpRequests();

  ApiProvider({@required this.httpClient});

  Future<List<dynamic>> getPosts() async {
    final postsEndpoint = ApiEndpoints.posts();
    return await _httpRequest.get(httpClient: httpClient, url: postsEndpoint);
  }

  Future<List<dynamic>> getComments(int postId) async {
    final commentsEndpoint = ApiEndpoints.comments();
    return await _httpRequest.get(
        httpClient: httpClient,
        url: commentsEndpoint,
        param: '?postId=$postId');
  }
}
