import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  const gradient = LinearGradient(colors: [Colors.blue, Colors.green]);

  testWidgets('SocialMediaFeed skips zero reach', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SocialMediaFeed(
            items: [
              SocialReachItem(
                label: 'X',
                icon: SizedBox.shrink(),
                gradient: gradient,
                reach: 0,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SocialMediaPill), findsNothing);
  });

  testWidgets('SocialMediaFeed shows pill for positive reach', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SocialMediaFeed(
            items: [
              SocialReachItem(
                label: 'Instagram',
                icon: Icon(Icons.star),
                gradient: gradient,
                reach: 50,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SocialMediaPill), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('50%'), findsOneWidget);
  });

  test('buildSocialReachItems merges map and config', () {
    final items = buildSocialReachItems(
      reachByPlatformKey: {'a': 10, 'b': 20, 'unknown': 99},
      configByPlatformKey: {
        'a': SocialPlatformConfig(
          label: 'A',
          icon: const SizedBox.shrink(),
          gradient: gradient,
        ),
        'b': SocialPlatformConfig(
          label: 'B',
          icon: const SizedBox.shrink(),
          gradient: gradient,
        ),
      },
    );

    expect(items, hasLength(2));
    expect(items.map((e) => e.label).toList(), ['A', 'B']);
  });
}
