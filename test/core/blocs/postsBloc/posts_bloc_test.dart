import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/models/post_model.dart';
import 'package:zemoga_posts/core/services/repositories/repositories.dart';

import '../../../mock_responses.dart';

class MockPostsBloc extends MockBloc<PostsState> implements PostsBloc {}

class MockPostsRepository extends Mock implements PostsRepository {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  PostsBloc mockPostsBloc;
  MockPostsRepository mockPostsRepository;

  setUp(() async {
    mockPostsBloc = MockPostsBloc();
    mockPostsRepository = MockPostsRepository();
  });

  tearDown(() {
    mockPostsBloc?.close();
  });

  group('Test PostsBloc', () {
    test('PostsLoaded state is correct', () {
      when(mockPostsBloc.state)
          .thenReturn(PostsLoaded(postsModel: mockPosts, users: []));
      expect(
          mockPostsBloc.state, PostsLoaded(postsModel: mockPosts, users: []));
    });

    test('Assert post repository should return an assertion error', () {
      expect(() => PostsRepository(apiProvider: null),
          throwsA(isA<AssertionError>()));
    });
  });

  group('Tests bloc states', () {
    blocTest<PostsBloc, PostsState>(
      'Fetch posts',
      build: () {
        when(mockPostsRepository.getPosts()).thenAnswer((_) async => mockPosts);
        return PostsBloc(postsRepository: mockPostsRepository);
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: [PostsLoading(), PostsLoaded(postsModel: mockPosts, users: [])],
    );

    blocTest<PostsBloc, PostsState>(
      'Fetch comments',
      build: () {
        when(mockPostsRepository.getPosts()).thenAnswer((_) async => mockPosts);
        when(mockPostsRepository.getUsers()).thenAnswer((_) async => mockUsers);
        when(mockPostsRepository.getComments(1))
            .thenAnswer((_) async => mockComments);
        return PostsBloc(postsRepository: mockPostsRepository);
      },
      act: (bloc) async {
        bloc.add(FetchPosts());
        await bloc.first;
        bloc.add(FetchPostInfo(postId: 1, userId: 1));
      },
      expect: [
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: [])
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'Favorite post',
      build: () {
        when(mockPostsRepository.getPosts()).thenAnswer((_) async => mockPosts);
        when(mockPostsRepository.getUsers()).thenAnswer((_) async => mockUsers);
        when(mockPostsRepository.getComments(1))
            .thenAnswer((_) async => mockComments);
        return PostsBloc(postsRepository: mockPostsRepository);
      },
      act: (bloc) async {
        bloc.add(FetchPosts());
        await bloc.first;
        bloc.add(FavoritePost(postId: 1));
      },
      expect: [
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: [])
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'Delete posts',
      build: () {
        when(mockPostsRepository.getPosts()).thenAnswer((_) async => mockPosts);
        when(mockPostsRepository.getUsers()).thenAnswer((_) async => mockUsers);
        when(mockPostsRepository.getComments(1))
            .thenAnswer((_) async => mockComments);
        return PostsBloc(postsRepository: mockPostsRepository);
      },
      act: (bloc) async {
        bloc.add(FetchPosts());
        await bloc.first;
        bloc.add(DeletePosts());
      },
      expect: [
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(postsModel: PostModel(posts: []), users: []),
        PostsDeleted()
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'Delete post',
      build: () {
        when(mockPostsRepository.getPosts()).thenAnswer((_) async => mockPosts);
        when(mockPostsRepository.getUsers()).thenAnswer((_) async => mockUsers);
        when(mockPostsRepository.getComments(1))
            .thenAnswer((_) async => mockComments);
        return PostsBloc(postsRepository: mockPostsRepository);
      },
      act: (bloc) async {
        bloc.add(FetchPosts());
        await bloc.first;
        bloc.add(DeletePost(postId: 1));
      },
      expect: [
        PostsLoading(),
        PostsLoaded(postsModel: mockPosts, users: []),
        PostsLoading(),
        PostDeleted(),
        PostsLoaded(postsModel: mockPosts, users: [])
      ],
    );
  });
}
