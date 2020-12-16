import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/services/repositories/repos/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({@required this.postsRepository}) : super(PostsInitial());

  final PostsRepository postsRepository;

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is FetchPosts) {
      yield* _fetchPosts(event);
    }
  }

  Stream<PostsState> _fetchPosts(FetchPosts event) async* {
    yield PostsLoading();
    try {
      final List<PostModel> postList = new List();
      final response = await postsRepository.getPosts();

      for (var i = 0; i < response.length; i++) {
        postList.add(PostModel.fromJson(response[i])
          ..read = i < 20 ? false : true
          ..body = response[i]['body'].replaceAll(new RegExp(r"[\n]"), " "));
      }
      yield PostsLoaded(posts: postList);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }
}
