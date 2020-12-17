import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

import '../widgets.dart';
import 'widgets/widgets.dart';

class PlatformTabBarTile extends PlatformStatelessWidget {
  const PlatformTabBarTile({Key key, @required this.post, @required this.onTap})
      : super(key: key);

  final PostModel post;
  final Function onTap;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(onTap: onTap, child: AndroidTile(post: post)));
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(onTap: onTap, child: IosTile(post: post)));
  }
}
