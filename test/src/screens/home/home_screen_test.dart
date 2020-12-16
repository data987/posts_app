import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zemoga_posts/core/services/repositories/repos/posts_repository.dart';
import 'package:zemoga_posts/src/screens/home/home_screen.dart';
import 'package:zemoga_posts/src/widgets/widgets.dart';

import '../../../base_tester.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
  });
  group('Render main structure and test tab behavior', () {
    testWidgets('HomeScreen exists', (tester) async {
      final homeKey = Key('home-screen-key');
      await tester.pumpWidget(
          baseTester(HomeScreen(key: homeKey), mockPostsRepository));
      expect(find.byKey(homeKey), findsOneWidget);
    });

    group('Test custom widgets depending the platform', () {
      testWidgets('IosBar renders on iOS', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        await tester.pumpWidget(baseTester(HomeScreen(), mockPostsRepository));
        expect(find.byType(IosBar), findsOneWidget);
        expect(find.byType(AndroidBar), findsNothing);
        debugDefaultTargetPlatformOverride = null;
      });
      testWidgets('AndroidBar renders on android', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        await tester.pumpWidget(baseTester(HomeScreen(), mockPostsRepository));
        expect(find.byType(AndroidBar), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('Tap on tab-bar-favorites and show favorites content on iOS',
          (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        await tester.pumpWidget(baseTester(HomeScreen(), mockPostsRepository));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('tab-bar-content-all')), findsOneWidget);

        await tester.tap(find.byKey(Key('tab-bar-favorites')));
        await tester.pump();
        expect(find.byKey(Key('tab-bar-content-all')), findsNothing);
        expect(find.byKey(Key('tab-bar-content-favorites')), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      }, skip: true);

      testWidgets(
          'Tap on tab-bar-favorites and show favorites content on Android',
          (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        await tester.pumpWidget(baseTester(HomeScreen(), mockPostsRepository));
        expect(find.byKey(Key('tab-bar-content-all')), findsOneWidget);

        await tester.tap(find.byKey(Key('tab-bar-favorites')));
        await tester.pumpAndSettle(Duration(seconds: 2));
        expect(find.byKey(Key('tab-bar-content-all')), findsNothing);
        expect(find.byKey(Key('tab-bar-content-favorites')), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      }, skip: true);
    });
  });
}
