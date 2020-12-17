import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
import 'package:zemoga_posts/src/screens/home/home_content.dart';
import 'package:zemoga_posts/src/screens/home/home_screen.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import '../../../base_tester.dart';
import '../../../mock_responses.dart';

class MockPostsBloc extends MockBloc<PostsState> implements PostsBloc {}

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
        value: mockPostsBloc, child: HomeScreen(key: key));
  }

  group('Render main structure and test tab behavior', () {
    testWidgets('HomeScreen exists', (tester) async {
      final homeKey = Key('home-screen-key');
      await tester.pumpWidget(baseTester(baseMockWidget(key: homeKey)));
      expect(find.byKey(homeKey), findsOneWidget);
    });

    group('Test custom widgets depending the platform', () {
      testWidgets('IosBar renders on iOS', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        await tester.pumpWidget(baseTester(baseMockWidget()));
        expect(find.byType(IosBar), findsOneWidget);
        expect(find.byType(AndroidBar), findsNothing);
        debugDefaultTargetPlatformOverride = null;
      });
      testWidgets('AndroidBar renders on android', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        await tester.pumpWidget(baseTester(baseMockWidget()));
        expect(find.byType(IosBar), findsNothing);
        expect(find.byType(AndroidBar), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('Tap on tab-bar-favorites and show favorites content on iOS',
          (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        when(mockPostsBloc.state)
            .thenReturn(PostsLoaded(posts: mockPosts, users: []));

        await tester.pumpWidget(baseTester(baseMockWidget()));
        expect(find.byType(HomeContent), findsOneWidget);
        expect(find.byKey(Key('tab-bar-content-all')), findsOneWidget);

        await tester.tap(find.byKey(Key('tab-bar-favorites')));
        await tester.pump();
        expect(find.byKey(Key('tab-bar-content-all')), findsNothing);
        expect(find.byKey(Key('tab-bar-content-favorites')), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets(
          'Tap on tab-bar-favorites and show favorites content on Android',
          (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        when(mockPostsBloc.state)
            .thenReturn(PostsLoaded(posts: mockPosts, users: []));

        await tester.pumpWidget(baseTester(baseMockWidget()));
        expect(find.byKey(Key('tab-bar-content-all')), findsOneWidget);

        await tester.tap(find.byKey(Key('tab-bar-favorites')));
        await tester.pumpAndSettle(Duration(seconds: 2));
        expect(find.byKey(Key('tab-bar-content-all')), findsNothing);
        expect(find.byKey(Key('tab-bar-content-favorites')), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      });
    });
  });
}
