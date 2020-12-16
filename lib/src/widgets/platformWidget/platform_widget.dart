import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key key}) : super(key: key);

  Widget buildIosWidget(BuildContext context);
  Widget buildAndroidWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;

    return _platform == TargetPlatform.iOS
        ? buildIosWidget(context)
        : buildAndroidWidget(context);
  }
}
