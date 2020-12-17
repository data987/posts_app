import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import 'widgets/post_info_content.dart';

class PostInfoScreen extends StatefulWidget {
  const PostInfoScreen({Key key, @required this.post}) : super(key: key);

  final PostModel post;

  @override
  _PostInfoScreenState createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  @override
  void initState() {
    context
        .read<PostsBloc>()
        .add(FetchPostInfo(postId: widget.post.id, userId: widget.post.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 45.0),
          child: PlatformBar(
            title: 'Post',
            onTap: () => context
                .read<PostsBloc>()
                .add(FavoritePost(postId: widget.post.id)),
            postInfo: true,
            post: widget.post,
          )),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is PostsLoaded) {
          return PostInfoContent(post: widget.post);
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
