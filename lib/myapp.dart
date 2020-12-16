import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/services/repositories/http_repositories.dart';

import 'src/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(postsRepository: postsRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts',
        theme: ThemeData(
          primaryColor: Color(0xFF2bb000),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
