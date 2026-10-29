import 'package:flutter_test/flutter_test.dart';
import 'package:cat_tablet/main.dart';

void main() {
  testWidgets('Tablet app renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const TabletApp());
    expect(find.text('CAT Tablet Console'), findsOneWidget);
    expect(find.text('运营概览'), findsOneWidget);
  });
}