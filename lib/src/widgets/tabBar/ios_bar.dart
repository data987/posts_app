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
    0: Text('All'),
    1: Text('Favorites')
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoNavigationBar(
          actionsForegroundColor: Colors.white,
          backgroundColor: Color(0xFF2bb000),
          middle: Text(widget.title, style: TextStyle(color: Colors.white)),
          trailing: InkWell(
              onTap: widget.reload, child: Icon(Icons.refresh, size: 25)),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: CupertinoSegmentedControl(
              borderColor: Color(0xFF2bb000),
              selectedColor: Color(0xFF2bb000),
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
