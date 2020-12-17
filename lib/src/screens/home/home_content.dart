import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

class HomeContent extends StatelessWidget {
  const HomeContent(
      {Key key,
      @required this.posts,
      @required this.tabController,
      @required this.groupValueIndex})
      : super(key: key);

  final List<Post> posts;
  final TabController tabController;
  final int groupValueIndex;

  List<Widget> content() {
    return [
      TabBarContent(key: Key('tab-bar-content-all'), posts: posts),
      TabBarContent(
          key: Key('tab-bar-content-favorites'),
          posts: posts.where((post) => post.favorite).toList())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return getPlatform(context) == TargetPlatform.iOS
        ? content()[groupValueIndex]
        : TabBarView(
            controller: tabController,
            children: content(),
          );
  }
}
