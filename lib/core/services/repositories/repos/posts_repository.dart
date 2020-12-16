import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/services/api/api_provider.dart';

class PostsRepository {
  final ApiProvider apiProvider;

  PostsRepository({@required this.apiProvider});

  Future<List<dynamic>> getPosts() async {
    final List<dynamic> posts = await apiProvider.getPosts();
    return posts;
  }
}
