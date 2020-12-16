import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
