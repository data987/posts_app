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
  PostsLoaded({@required this.postsModel, @required this.users});

  final PostModel postsModel;
  final List<User> users;

  @override
  List<Object> get props => [postsModel, users];
}

class PostsFailed extends PostsState {
  PostsFailed({@required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class PostsDeleted extends PostsState {}

class PostDeleted extends PostsState {}
