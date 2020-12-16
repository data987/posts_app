import 'package:flutter/material.dart';

class AndroidBar extends StatelessWidget {
  const AndroidBar(
      {Key key,
      @required this.title,
      @required this.onTap,
      this.tabController,
      this.postInfo = false})
      : super(key: key);

  final String title;
  final Function onTap;
  final TabController tabController;
  final bool postInfo;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title:
          !postInfo ? Text(title, style: TextStyle(color: Colors.white)) : '',
      leading: postInfo
          ? Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, size: 25, color: Colors.white),
              ),
            )
          : null,
      actions: [
        Material(
          type: MaterialType.transparency,
          child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(postInfo ? Icons.star_border : Icons.refresh,
                    size: 25, color: Colors.white),
              )),
        )
      ],
      bottom: !postInfo
          ? TabBar(
              controller: tabController,
              tabs: [
                Tab(key: Key('tab-bar-all'), text: 'All'),
                Tab(key: Key('tab-bar-favorites'), text: 'Favorites')
              ],
            )
          : null,
    );
  }
}
