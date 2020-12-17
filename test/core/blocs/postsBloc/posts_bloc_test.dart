import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/core/services/repositories/repositories.dart';

import '../../../mock_responses.dart';

class MockPostsBloc extends MockBloc<PostsState> implements PostsBloc {}

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  PostsBloc mockPostsBloc;
  MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsBloc = MockPostsBloc();
    mockPostsRepository = MockPostsRepository();
  });

  tearDown(() {
    mockPostsBloc?.close();
  });

  group('Test PostsBloc', () {
    test('PostsLoaded state is correct', () {
      when(mockPostsBloc.state)
          .thenReturn(PostsLoaded(posts: mockPosts, users: []));
      expect(mockPostsBloc.state, PostsLoaded(posts: mockPosts, users: []));
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
      expect: [PostsLoading(), PostsLoaded(posts: mockPosts, users: [])],
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
        PostsLoaded(posts: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(posts: mockPosts, users: [])
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
        PostsLoaded(posts: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(posts: mockPosts, users: [])
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
        PostsLoaded(posts: mockPosts, users: []),
        PostsLoading(),
        PostsLoaded(posts: [], users: []),
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
        PostsLoaded(posts: mockPosts, users: []),
        PostsLoading(),
        PostDeleted(),
        PostsLoaded(posts: mockPosts, users: [])
      ],
    );
  });
}
