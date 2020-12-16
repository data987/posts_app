part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class NoRequests extends PostsState {}

class PostsLoaded extends PostsState {
  PostsLoaded({@required this.posts, @required this.users});

  final List<PostModel> posts;
  final List<User> users;

  @override
  List<Object> get props => [posts, users];
}

class PostsFailed extends PostsState {
  PostsFailed({@required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class PostsDeleted extends PostsState {}

class PostDeleted extends PostsState {}
