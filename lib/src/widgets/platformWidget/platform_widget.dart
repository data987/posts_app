import 'package:flutter/material.dart';

abstract class PlatformStatelessWidget extends StatelessWidget {
  const PlatformStatelessWidget({Key key}) : super(key: key);

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
