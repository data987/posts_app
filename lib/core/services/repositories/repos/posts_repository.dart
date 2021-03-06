import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/models/comment_model.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/models/user_model.dart';
import 'package:zemoga_posts/core/services/api/api_provider.dart';

class PostsRepository {
  final ApiProvider apiProvider;

  PostsRepository({@required this.apiProvider}) : assert(apiProvider != null);

  Future<PostModel> getPosts() async {
    PostModel postModel;
    final List<Post> postList = [];
    final List<dynamic> posts = await apiProvider.getPosts();

    for (var i = 0; i < posts.length; i++) {
      postList.add(Post.fromJson(posts[i])
        ..read = i < 20 ? false : true
        ..body = posts[i]['body'].replaceAll(new RegExp(r"[\n]"), " "));
    }
    postModel = new PostModel(posts: postList);
    return postModel;
  }

  Future<List<Comment>> getComments(int postId) async {
    final List<Comment> commentList = new List();
    final List<dynamic> comments = await apiProvider.getComments(postId);

    for (var i = 0; i < comments.length; i++) {
      commentList.add(Comment.fromJson(comments[i])
        ..body = comments[i]['body'].replaceAll(new RegExp(r"[\n]"), " "));
    }
    return commentList;
  }

  Future<List<User>> getUsers() async {
    final List<dynamic> users = await apiProvider.getUsers();
    final List<User> userList =
        users.map((user) => User.fromJson(user)).toList();

    return userList;
  }
}
