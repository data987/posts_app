import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zemoga_posts/core/models/comment_model.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/models/user_model.dart';
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
    if (state is PostsLoaded && event is FetchPostInfo) {
      yield* _fetchPostInfo(event, state);
    }
    if (state is PostsLoaded && event is FavoritePost) {
      yield* _favoritePost(event, state);
    }
    if (state is PostsLoaded && event is DeletePosts) {
      yield* _deletePosts(event, state);
    }
    if (state is PostsLoaded && event is DeletePost) {
      yield* _deletePostById(event, state);
    }
  }

  Stream<PostsState> _fetchPosts(FetchPosts event, PostsState state) async* {
    yield PostsLoading();
    try {
      if (state is PostsInitial || state is PostsDeleted) {
        final List<PostModel> posts = await postsRepository.getPosts();
        yield PostsLoaded(posts: posts, users: new List());
      }
      if (state is PostsLoaded)
        yield PostsLoaded(posts: state.posts, users: state.users);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _fetchPostInfo(
      FetchPostInfo event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      final isLoaded = state.posts
          .where((post) => post.id == event.postId)
          .any((post) => post.comments != null);
      final List<PostModel> postList = [];
      final List<User> userList = [];

      if (!isLoaded) {
        final List<Comment> getComments =
            await postsRepository.getComments(event.postId);
        final User userById = await _getUserById(event.userId, state.users);

        state.posts.forEach((post) {
          if (post.id == event.postId) {
            postList.add(post
              ..user = userById
              ..comments = getComments
              ..read = true);
          } else {
            postList.add(post);
          }
        });
      } else {
        yield NoRequests();
      }

      yield PostsLoaded(
          posts: isLoaded ? state.posts : postList,
          users: isLoaded ? state.users : userList);
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

      yield PostsLoaded(posts: postsWithFavorites, users: state.users);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Future<User> _getUserById(int userId, List users) async {
    final List<User> getUsers =
        users.length > 0 ? users : await postsRepository.getUsers();
    final User getUser = getUsers.where((user) => user.id == userId).first;
    return getUser;
  }

  Stream<PostsState> _deletePosts(DeletePosts event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      yield PostsLoaded(posts: [], users: state.users);
      yield PostsDeleted();
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _deletePostById(
      DeletePost event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      state.posts.removeWhere((post) => post.id == event.postId);
      yield PostDeleted();
      yield PostsLoaded(posts: state.posts, users: state.users);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }
}
