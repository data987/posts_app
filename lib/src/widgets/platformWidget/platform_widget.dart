import 'package:flutter/material.dart';

getPlatform(context) => Theme.of(context).platform;

abstract class PlatformStatelessWidget extends StatelessWidget {
  const PlatformStatelessWidget({Key key}) : super(key: key);

  Widget buildIosWidget(BuildContext context);
  Widget buildAndroidWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return getPlatform(context) == TargetPlatform.iOS
        ? buildIosWidget(context)
        : buildAndroidWidget(context);
  }
}
