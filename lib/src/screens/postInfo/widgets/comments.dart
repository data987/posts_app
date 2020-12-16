import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';

class Comments extends StatelessWidget {
  const Comments({Key key, @required this.title, @required this.comments})
      : super(key: key);

  final String title;
  final dynamic comments;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            color: Colors.grey[300],
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Text(title.toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10.0),
          for (var comment in comments) ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Text(comment.body),
            )
          ]
        ],
      ),
    );
  }
}
