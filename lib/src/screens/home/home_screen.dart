import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import 'home_content.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PostsBloc _postsBloc;
  int groupValueIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _postsBloc = BlocProvider.of<PostsBloc>(context);
    _postsBloc.add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: true,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100.0),
            child: PlatformBar(
                title: 'Post',
                onTap: () => context.read<PostsBloc>().add(FetchPosts()),
                androidTabController: _tabController,
                iosChangeIndex: (index) =>
                    setState(() => groupValueIndex = index))),
        body: _renderPosts(context),
        bottomSheet: PlatformBottomButton(
            deletePosts: () => context.read<PostsBloc>().add(DeletePosts())),
        floatingActionButton: PlatformFloatingButton(
            deletePosts: () => context.read<PostsBloc>().add(DeletePosts())));
  }

  Widget _renderPosts(BuildContext context) {
    var _iosPlatform = getPlatform(context) == TargetPlatform.iOS;
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
          return Padding(
            padding: EdgeInsets.only(bottom: _iosPlatform ? 50.0 : 0.0),
            child: HomeContent(
              tabController: _tabController,
              posts: state.posts,
              groupValueIndex: groupValueIndex,
            ),
          );
        } else if (state is PostsFailed) {
          return Center(child: Text(state.error));
        } else if (state is PostsDeleted) {
          return Center(child: Text('There are no posts here!'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
