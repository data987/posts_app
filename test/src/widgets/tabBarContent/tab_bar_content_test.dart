import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zemoga_posts/core/blocs/postsBloc/posts_bloc.dart';
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
        child: TabBarContent(key: key, posts: mockPosts.posts));
  }

  testWidgets('Delete a post', (tester) async {
    await tester.pumpWidget(baseTester(baseMockWidget()));
    expect(find.byKey(Key('tab-bar-content-slidable')), findsNWidgets(4));
    await tester.drag(find.byKey(Key('tab-bar-content-slidable')).first,
        const Offset(-200.0, 0.0));
    await tester.pumpAndSettle(Duration(milliseconds: 200));
    expect(find.byKey(Key('tab-bar-content-delete-posts')), findsOneWidget);

    await tester.tap(find.byKey(Key('tab-bar-content-delete-posts')));
    await tester.pumpAndSettle(Duration(milliseconds: 700));
    expect(find.byKey(Key('tab-bar-content-slidable')), findsNWidgets(3));
  });
}
