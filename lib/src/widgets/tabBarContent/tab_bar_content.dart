import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'tab_bar_tile.dart';

class TabBarContent extends StatelessWidget {
  const TabBarContent(
      {Key key, @required this.posts, @required this.deletePost})
      : super(key: key);

  final List<dynamic> posts;
  final Function deletePost;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: TabBarTile(post: posts[index]),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: deletePost,
                ),
              ]);
        });
  }
}
