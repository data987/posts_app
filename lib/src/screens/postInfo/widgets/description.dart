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
      padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text(text, style: TextStyle(fontSize: 13, height: 1.4))
        ],
      ),
    );
  }
}
