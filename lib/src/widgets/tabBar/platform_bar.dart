import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

import '../widgets.dart';

class PlatformBar extends PlatformStatelessWidget {
  const PlatformBar(
      {Key key,
      @required this.onTap,
      @required this.title,
      this.postInfo = false,
      this.post,
      this.iosChangeIndex,
      this.androidTabController})
      : super(key: key);

  final String title;
  final Function onTap;
  final bool postInfo;
  final PostModel post;
  final Function iosChangeIndex;
  final TabController androidTabController;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AndroidBar(
        tabController: androidTabController,
        title: title,
        onTap: onTap,
        postInfo: postInfo,
        post: post);
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return IosBar(
        title: title,
        onTap: onTap,
        postInfo: postInfo,
        post: post,
        changeIndex: iosChangeIndex);
  }
}
