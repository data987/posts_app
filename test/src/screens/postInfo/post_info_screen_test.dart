import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/src/screens/postInfo/post_info_screen.dart';
import 'package:zemoga_posts/src/screens/postInfo/widgets/post_info_content.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import '../../../base_tester.dart';
import '../../../mock_responses.dart';

void main() {
  PostsBloc mockPostsBloc;

  setUp(() {
    mockPostsBloc = MockPostsBloc();
  });

  tearDown(() {
    mockPostsBloc?.close();
  });

  baseMockWidget({key}) {
    return BlocProvider.value(
        value: mockPostsBloc,
        child: PostInfoScreen(key: key, post: mockPostsComments[0]));
  }

  testWidgets('PostInfoScreen exists', (tester) async {
    final postInfoScreenKey = Key('post-info-screen-key');
    await tester.pumpWidget(baseTester(baseMockWidget(key: postInfoScreenKey)));
    expect(find.byKey(postInfoScreenKey), findsOneWidget);
  });

  group('Testing main structure', () {
    testWidgets('IosBar renders on iOS', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await tester.pumpWidget(baseTester(baseMockWidget()));
      expect(find.byType(IosBar), findsOneWidget);
      expect(find.byType(AndroidBar), findsNothing);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('render PostInfoContent when the state is loaded',
        (tester) async {
      expect(find.byType(PostInfoContent), findsNothing);
      when(mockPostsBloc.state)
          .thenReturn(PostsLoaded(posts: mockPosts, users: []));
      await tester.pumpWidget(baseTester(baseMockWidget()));
      expect(find.byType(PostInfoContent), findsOneWidget);
    });

    testWidgets('render CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(baseTester(baseMockWidget()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(PostInfoContent), findsNothing);
    });
  });
}
