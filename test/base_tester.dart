import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/services/repositories/repos/posts_repository.dart';

Widget baseTester(Widget child, PostsRepository postsRepository) {
  return BlocProvider<PostsBloc>(
      create: (context) => PostsBloc(postsRepository: postsRepository),
      child: MaterialApp(home: child));
}
