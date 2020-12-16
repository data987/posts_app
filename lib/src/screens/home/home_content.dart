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

  final List<PostModel> posts;
  final TabController tabController;
  final int groupValueIndex;

  List<Widget> content() {
    return [
      TabBarContent(
          key: Key('tab-bar-content-all'), posts: posts, deletePost: () {}),
      TabBarContent(
          key: Key('tab-bar-content-favorites'),
          posts: posts.where((post) => post.favorite).toList(),
          deletePost: () {})
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return _platform == TargetPlatform.iOS
        ? content()[groupValueIndex]
        : TabBarView(
            controller: tabController,
            children: content(),
          );
  }
}
