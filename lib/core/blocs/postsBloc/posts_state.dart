part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  PostsLoaded({@required this.posts});

  final List<PostModel> posts;

  @override
  List<Object> get props => [posts];
}

class PostsFailed extends PostsState {}

class PostsDeleted extends PostsState {}

class PostDeleted extends PostsState {}
