import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosBar extends StatefulWidget {
  const IosBar(
      {Key key, @required this.title, @required this.reload, this.changeIndex})
      : super(key: key);

  final String title;
  final Function reload;
  final Function changeIndex;

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
    return Column(
      children: [
        CupertinoNavigationBar(
          actionsForegroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          middle: Text(widget.title, style: TextStyle(color: Colors.white)),
          trailing: InkWell(
              onTap: widget.reload, child: Icon(Icons.refresh, size: 25)),
        ),
        Expanded(
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
      ],
    );
  }
}
