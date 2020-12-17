import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

import 'tab_bar_tile.dart';

class TabBarContent extends StatelessWidget {
  const TabBarContent({Key key, @required this.posts}) : super(key: key);

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    final _myListKey = GlobalKey<AnimatedListState>();

    return AnimatedList(
      key: _myListKey,
      initialItemCount: posts.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index, animation) {
        return BlocProvider<PostsBloc>.value(
            value: BlocProvider.of<PostsBloc>(context),
            child:
                _buildItem(context: context, post: posts[index], index: index));
      },
    );
  }

  _deleteItem(context, int index) {
    var user = posts.removeAt(index);
    AnimatedList.of(context).removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
        child: SizeTransition(
          sizeFactor:
              CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
          axisAlignment: 0.0,
          child: _buildItem(post: user),
        ),
      );
    }, duration: Duration(milliseconds: 500));
    Future.delayed(Duration(milliseconds: 600)).then((_) =>
        BlocProvider.of<PostsBloc>(context).add(DeletePost(postId: user.id)));
  }

  _buildItem({context, PostModel post, int index}) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: TabBarTile(post: post),
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => _deleteItem(context, index)),
        ]);
  }
}
