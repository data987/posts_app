import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key key, @required this.title, @required this.userInfo})
      : super(key: key);

  final String title;
  final dynamic userInfo;

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
          ..._userInfo()
        ],
      ),
    );
  }

  List<Widget> _userInfo() {
    return [
      Row(
        children: [Text('Name:'), Text(userInfo.name)],
      ),
      Row(
        children: [Text('Email:'), Text(userInfo.email)],
      ),
      Row(
        children: [Text('Phone:'), Text(userInfo.phone)],
      ),
      Row(
        children: [Text('Website:'), Text(userInfo.website)],
      ),
    ];
  }
}
