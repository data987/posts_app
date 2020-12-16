import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/models/comment_model.dart';
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
      yield* _fetchPosts(event, state);
    }
    if (state is PostsLoaded && event is FetchComments) {
      yield* _fetchComments(event, state);
    }
    if (state is PostsLoaded && event is FavoritePost) {
      yield* _favoritePost(event, state);
    }
  }

  Stream<PostsState> _fetchPosts(FetchPosts event, PostsState state) async* {
    yield PostsLoading();
    try {
      if (state is PostsInitial) {
        final List<PostModel> posts = await postsRepository.getPosts();
        yield PostsLoaded(posts: posts);
      }
      if (state is PostsLoaded) yield PostsLoaded(posts: state.posts);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _fetchComments(
      FetchComments event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      final isLoaded = state.posts
          .where((post) => post.id == event.postId)
          .any((post) => post.comments != null);
      final List<PostModel> addCommentToPost = [];

      if (!isLoaded) {
        final List<Comment> getComments =
            await postsRepository.getComments(event.postId);
        state.posts.forEach((post) {
          if (post.id == event.postId) {
            addCommentToPost.add(post
              ..comments = getComments
              ..read = true);
          } else {
            addCommentToPost.add(post);
          }
        });
      } else {
        yield NoRequests();
      }

      yield PostsLoaded(posts: isLoaded ? state.posts : addCommentToPost);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _favoritePost(
      FavoritePost event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      final List<PostModel> postsWithFavorites = [];
      state.posts.forEach((post) {
        if (post.id == event.postId) {
          postsWithFavorites.add(post..favorite = !post.favorite);
        } else {
          postsWithFavorites.add(post);
        }
      });

      yield PostsLoaded(posts: postsWithFavorites);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }
}
