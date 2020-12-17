import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

class AndroidBar extends StatefulWidget {
  const AndroidBar(
      {Key key,
      @required this.title,
      @required this.onTap,
      this.tabController,
      this.postInfo = false,
      this.post})
      : super(key: key);

  final String title;
  final Function onTap;
  final TabController tabController;
  final bool postInfo;
  final PostModel post;

  @override
  _AndroidBarState createState() => _AndroidBarState();
}

class _AndroidBarState extends State<AndroidBar> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    final isFavorite = widget.post != null && widget.post.favorite
        ? Icons.star
        : Icons.star_border;

    return AppBar(
      title: !widget.postInfo
          ? Text(widget.title, style: TextStyle(color: Colors.white))
          : '',
      leading: widget.postInfo
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
              onTap: () => setState(() => widget.onTap()),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(widget.postInfo ? isFavorite : Icons.refresh,
                    size: 25, color: Colors.white),
              )),
        )
      ],
      bottom: !widget.postInfo
          ? TabBar(
              controller: widget.tabController,
              tabs: [
                Tab(key: Key('tab-bar-all'), text: 'All'),
                Tab(key: Key('tab-bar-favorites'), text: 'Favorites')
              ],
            )
          : null,
    );
  }
}
