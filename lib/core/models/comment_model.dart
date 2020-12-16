// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

Comment postModelFromJson(String str) => Comment.fromJson(json.decode(str));

String postModelToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["postId"] == null ? null : json["postId"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId == null ? null : postId,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "body": body == null ? null : body,
      };
}
