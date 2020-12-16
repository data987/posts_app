part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostsEvent {}

class FetchComments extends PostsEvent {}

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
