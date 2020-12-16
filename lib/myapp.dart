import 'package:flutter/material.dart';
import 'package:zemoga_posts/src/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts',
      theme: ThemeData(
        primaryColor: Color(0xFF2bb000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
