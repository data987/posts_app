import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

class PostInfoScreen extends StatelessWidget {
  const PostInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100.0),
          child: _renderTabBar(_platform)),
      body: Center(child: Text('Holaaa')),
    );
  }

  Widget _renderTabBar(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? IosBar(
            title: 'Post',
            onTap: () {},
            postInfo: true,
          )
        : AndroidBar(title: 'Post', onTap: () {}, postInfo: true);
  }
}
