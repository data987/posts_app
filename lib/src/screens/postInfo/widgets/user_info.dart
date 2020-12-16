import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/user_model.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key key, @required this.title, @required this.userInfo})
      : super(key: key);

  final String title;
  final User userInfo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding:
          EdgeInsets.only(top: 15.0, bottom: 20.0, left: 20.0, right: 20.0),
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          ..._userInfo()
        ],
      ),
    );
  }

  List<Widget> _userInfo() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Text('Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userInfo?.name ?? '')
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Text('Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userInfo?.email ?? '')
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Text('Phone: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userInfo?.phone ?? '')
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Text('Website: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userInfo?.website ?? '')
          ],
        ),
      ),
    ];
  }
}
