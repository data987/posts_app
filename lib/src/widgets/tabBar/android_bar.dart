import 'package:flutter/material.dart';

class AndroidBar extends StatelessWidget {
  const AndroidBar(
      {Key key,
      @required this.title,
      @required this.reload,
      @required this.tabController})
      : super(key: key);

  final String title;
  final Function reload;
  final TabController tabController;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      actions: [
        InkWell(
            onTap: reload,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.refresh, size: 25),
            ))
      ],
      bottom: TabBar(
        controller: tabController,
        tabs: [
          Tab(key: Key('tab-bar-all'), text: 'All'),
          Tab(key: Key('tab-bar-favorites'), text: 'Favorites')
        ],
      ),
    );
  }
}
