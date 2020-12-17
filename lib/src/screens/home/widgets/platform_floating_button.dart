import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

class PlatformFloatingButton extends PlatformStatelessWidget {
  PlatformFloatingButton({@required this.deletePosts});

  final Function deletePosts;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: deletePosts,
      child: Icon(Icons.delete),
      backgroundColor: Colors.red[900],
    );
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return SizedBox();
  }
}
