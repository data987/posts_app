import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

import 'comments.dart';
import 'description.dart';
import 'user_info.dart';

class PostInfoContent extends StatelessWidget {
  const PostInfoContent({Key key, @required this.post}) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Description(title: 'Description', text: post.body),
          // UserInfo(title: 'User', userInfo: post.user),
          // Comments(title: 'Comments', comments: post.comments)
        ],
      ),
    );
  }
}
