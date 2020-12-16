import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

import 'tab_bar_tile.dart';

class TabBarContent extends StatelessWidget {
  const TabBarContent(
      {Key key, @required this.posts, @required this.deletePost})
      : super(key: key);

  final List<PostModel> posts;
  final Function deletePost;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: posts.length,
        itemBuilder: (_, int index) {
          return BlocProvider<PostsBloc>.value(
            value: BlocProvider.of<PostsBloc>(context),
            child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: TabBarTile(post: posts[index]),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: deletePost,
                  ),
                ]),
          );
        });
  }
}
