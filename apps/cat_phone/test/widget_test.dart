import 'package:flutter_test/flutter_test.dart';
import 'package:cat_core/cat_core.dart';
import 'package:cat_phone/main.dart';

void main() {
  testWidgets('Phone app renders with GoRouter shell',
      (WidgetTester tester) async {
    await initializeDependencies();
    await tester.pumpWidget(const PhoneApp());
    await tester.pump();

    expect(find.text('CUSTOM Phone'), findsOneWidget);
  });
}