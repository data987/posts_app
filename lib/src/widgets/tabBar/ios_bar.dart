import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

class IosBar extends StatefulWidget {
  const IosBar(
      {Key key,
      @required this.title,
      @required this.onTap,
      this.changeIndex,
      this.postInfo,
      this.post})
      : super(key: key);

  final String title;
  final Function onTap;
  final Function changeIndex;
  final bool postInfo;
  final Post post;

  @override
  _IosBarState createState() => _IosBarState();
}

class _IosBarState extends State<IosBar> {
  int groupValueIndex = 0;

  final Map<int, Widget> titleTabs = const <int, Widget>{
    0: Text('All', key: Key('tab-bar-all')),
    1: Text('Favorites', key: Key('tab-bar-favorites'))
  };

  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.post != null && widget.post.favorite
        ? Icons.star
        : Icons.star_border;

    return Column(
      children: [
        CupertinoNavigationBar(
          actionsForegroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          middle: Text(widget.title, style: TextStyle(color: Colors.white)),
          leading: _loadArrowBack(),
          trailing: Material(
            type: MaterialType.transparency,
            child: InkWell(
                onTap: () => setState(() => widget.onTap()),
                child: Icon(widget.postInfo ? isFavorite : Icons.refresh,
                    size: 25, color: Colors.white)),
          ),
        ),
        _loadTabBar()
      ],
    );
  }

  Widget _loadArrowBack() {
    return widget.postInfo
        ? Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
            ),
          )
        : SizedBox();
  }

  _loadTabBar() {
    return !widget.postInfo
        ? Expanded(
            child: Container(
              width: double.infinity,
              child: CupertinoSegmentedControl(
                borderColor: Theme.of(context).primaryColor,
                selectedColor: Theme.of(context).primaryColor,
                groupValue: groupValueIndex,
                onValueChanged: (value) {
                  setState(() {
                    groupValueIndex = value;
                    widget.changeIndex(value);
                  });
                },
                children: titleTabs,
              ),
            ),
          )
        : SizedBox();
  }
}
