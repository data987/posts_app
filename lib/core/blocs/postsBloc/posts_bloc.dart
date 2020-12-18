import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:zemoga_posts/core/models/comment_model.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/models/user_model.dart';
import 'package:zemoga_posts/core/services/repositories/repos/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends HydratedBloc<PostsEvent, PostsState> {
  PostsBloc({@required this.postsRepository}) : super(PostsInitial());

  @override
  PostsState fromJson(Map<String, dynamic> json) {
    try {
      final postModel = PostModel.fromJson(json);
      return PostsLoaded(postsModel: postModel, users: []);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(PostsState state) {
    if (state is PostsLoaded) {
      return state.postsModel.toJson();
    } else {
      return null;
    }
  }

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
        final PostModel posts = await postsRepository.getPosts();
        yield PostsLoaded(postsModel: posts, users: new List());
      }
      if (state is PostsLoaded)
        yield PostsLoaded(postsModel: state.postsModel, users: state.users);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _fetchPostInfo(
      FetchPostInfo event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      final isLoaded = state.postsModel.posts
          .where((post) => post.id == event.postId)
          .any((post) => post.comments != null);
      final List<Post> postList = [];
      final List<User> userList = [];

      if (!isLoaded) {
        final List<Comment> getComments =
            await postsRepository.getComments(event.postId);
        final User userById = await _getUserById(event.userId, state.users);

        state.postsModel.posts.forEach((post) {
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
          postsModel: isLoaded ? state.postsModel : PostModel(posts: postList),
          users: isLoaded ? state.users : userList);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _favoritePost(
      FavoritePost event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      final List<Post> postsWithFavorites = [];
      state.postsModel.posts.forEach((post) {
        if (post.id == event.postId) {
          postsWithFavorites.add(post..favorite = !post.favorite);
        } else {
          postsWithFavorites.add(post);
        }
      });

      yield PostsLoaded(
          postsModel: PostModel(posts: postsWithFavorites), users: state.users);
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
      yield PostsLoaded(postsModel: PostModel(posts: []), users: state.users);
      yield PostsDeleted();
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }

  Stream<PostsState> _deletePostById(
      DeletePost event, PostsLoaded state) async* {
    yield PostsLoading();
    try {
      state.postsModel.posts.removeWhere((post) => post.id == event.postId);
      yield PostDeleted();
      yield PostsLoaded(postsModel: state.postsModel, users: state.users);
    } catch (e) {
      yield PostsFailed(error: e.toString());
    }
  }
}
