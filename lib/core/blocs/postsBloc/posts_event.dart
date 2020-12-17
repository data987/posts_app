part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostsEvent {}

class FetchPostInfo extends PostsEvent {
  FetchPostInfo({@required this.postId, @required this.userId});

  final int postId;
  final int userId;

  @override
  List<Object> get props => [postId, userId];
}

class DeletePosts extends PostsEvent {}

class FavoritePost extends PostsEvent {
  FavoritePost({@required this.postId});

  final int postId;

  @override
  List<Object> get props => [postId];
}

class DeletePost extends PostsEvent {
  DeletePost({@required this.postId});

  final int postId;

  @override
  List<Object> get props => [postId];
}
