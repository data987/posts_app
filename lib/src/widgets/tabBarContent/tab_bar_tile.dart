import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/src/screens/postInfo/post_info_screen.dart';

import '../widgets.dart';
import 'widgets/widgets.dart';

class TabBarTile extends PlatformStatelessWidget {
  const TabBarTile({Key key, @required this.post}) : super(key: key);

  final PostModel post;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostInfoScreen(post: post))),
            child: AndroidTile(post: post)));
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostInfoScreen(post: post))),
            child: IosTile(post: post)));
  }
}
