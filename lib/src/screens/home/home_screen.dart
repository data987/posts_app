import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int groupValueIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  static Widget giveCenter(String yourText) {
    return Center(
      child: Text(
        "Text: $yourText",
        style: TextStyle(color: Colors.blue, fontSize: 20.0),
      ),
    );
  }

  List<Widget> bodies = [giveCenter("Home Page"), giveCenter("Search Page")];

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100.0),
            child: _renderTabBar(_platform)),
        body: _renderTabView(_platform));
  }

  Widget _renderTabBar(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? IosBar(
            title: 'Post',
            reload: () {},
            changeIndex: (index) => setState(() => groupValueIndex = index),
          )
        : AndroidBar(
            tabController: _tabController, title: 'Post', reload: () {});
  }

  Widget _renderTabView(TargetPlatform platform) {
    return platform == TargetPlatform.iOS
        ? bodies[groupValueIndex]
        : TabBarView(
            controller: _tabController,
            children: bodies,
          );
  }
}
