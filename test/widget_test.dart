import 'package:fady_portfolio/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const RootApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(RootApp), findsOneWidget);
  });
}
