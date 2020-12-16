import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';

class Description extends StatelessWidget {
  const Description({Key key, @required this.title, @required this.text})
      : super(key: key);

  final String title;
  final dynamic text;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text(text, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
