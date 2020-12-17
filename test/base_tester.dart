import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';

class MockPostsBloc extends MockBloc<PostsState> implements PostsBloc {}

Widget baseTester(Widget child) {
  return MaterialApp(home: child);
}
