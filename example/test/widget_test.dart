import 'package:flutter_test/flutter_test.dart';

import 'package:liquid_progress_indicator_example/main.dart';

void main() {
  testWidgets('Example shows package title and section', (tester) async {
    await tester.pumpWidget(const LiquidProgressIndicatorExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Liquid Progress Indicator'), findsOneWidget);
    expect(find.text('Social Media Reach'), findsOneWidget);
  });
}
