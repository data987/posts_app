import 'package:flutter/material.dart';

import '../widgets.dart';
import 'widgets/widgets.dart';

class TabBarTile extends PlatformWidget {
  const TabBarTile({Key key, @required this.post}) : super(key: key);

  final dynamic post;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AndroidTile(post: post);
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return IosTile(post: post);
  }
}
