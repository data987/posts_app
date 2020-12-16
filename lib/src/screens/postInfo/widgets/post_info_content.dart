import 'package:flutter/material.dart';

import 'comments.dart';
import 'description.dart';
import 'user_info.dart';

class PostInfoContent extends StatelessWidget {
  const PostInfoContent({Key key, @required this.post}) : super(key: key);

  final dynamic post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Description(title: 'Description', text: post.description),
          UserInfo(title: 'User', userInfo: post.user),
          Comments(title: 'Comments', comments: post.comments)
        ],
      ),
    );
  }
}
