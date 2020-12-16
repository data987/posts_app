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
    context.read<PostsBloc>().add(FetchComments(postId: widget.post.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 45.0),
          child: _renderTabBar(_platform)),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is PostsLoaded) {
          return PostInfoContent(post: widget.post);
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _renderTabBar(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? IosBar(
            title: 'Post',
            onTap: () => context
                .read<PostsBloc>()
                .add(FavoritePost(postId: widget.post.id)),
            postInfo: true,
            post: widget.post)
        : AndroidBar(
            title: 'Post',
            onTap: () => context
                .read<PostsBloc>()
                .add(FavoritePost(postId: widget.post.id)),
            postInfo: true);
  }
}
