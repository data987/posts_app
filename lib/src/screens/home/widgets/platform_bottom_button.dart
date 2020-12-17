import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/utils/size_config.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

class PlatformBottomButton extends PlatformStatelessWidget {
  PlatformBottomButton({@required this.deletePosts});

  final Function deletePosts;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Text('Delete All', style: TextStyle(fontSize: 16)),
        onPressed: deletePosts,
        color: Colors.red[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        textColor: Colors.white,
      ),
    );
  }
}
