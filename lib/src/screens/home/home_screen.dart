import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import 'home_content.dart';

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
    final _platform = Theme.of(context).platform;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100.0),
          child: _renderTabBar(_platform)),
      body: _renderPosts(context),
      bottomSheet: _renderBottomButton(_platform),
      floatingActionButton: _rednerFloatingButton(_platform),
    );
  }

  Widget _renderTabBar(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? IosBar(
            title: 'Posts',
            onTap: () {},
            changeIndex: (index) => setState(() => groupValueIndex = index),
          )
        : AndroidBar(
            tabController: _tabController, title: 'Posts', onTap: () {});
  }

  _renderBottomButton(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text('Delete All', style: TextStyle(fontSize: 16)),
              onPressed: () => {},
              color: Colors.red[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              textColor: Colors.white,
            ),
          )
        : null;
  }

  _rednerFloatingButton(TargetPlatform platform) {
    return platform == TargetPlatform.android
        ? FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.delete),
            backgroundColor: Colors.red[900],
          )
        : null;
  }

  Widget _renderPosts(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
          return HomeContent(
            tabController: _tabController,
            posts: state.posts,
            groupValueIndex: groupValueIndex,
          );
        } else if (state is PostsFailed)
          return Center(child: Text(state.error));
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
