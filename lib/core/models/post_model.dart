// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'comment_model.dart';
import 'user_model.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.posts,
  });

  PostModel copyWith({List<Post> posts}) {
    return PostModel(posts: posts ?? this.posts);
  }

  List<Post> posts;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        posts: json["posts"] == null
            ? null
            : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts == null
            ? null
            : List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.favorite,
    this.read,
    this.comments,
    this.user,
  });

  int userId;
  int id;
  String title;
  String body;
  bool favorite;
  bool read;
  List<Comment> comments;
  User user;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        favorite: json["favorite"] == null ? false : json["favorite"],
        read: json["read"] == null ? true : json["read"],
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "favorite": favorite == null ? false : favorite,
        "read": read == null ? true : read,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toJson())),
        "user": user == null ? null : user.toJson(),
      };
}
