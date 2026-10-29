import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_vehicle/main.dart';

void main() {
  testWidgets('Vehicle app renders sidebar and toggles selection', (WidgetTester tester) async {
    await tester.pumpWidget(const VehicleApp());

    expect(find.text('矿区地图'), findsWidgets);
    expect(find.text('Ready'), findsOneWidget);
    expect(find.text('运营概览'), findsOneWidget);

    await tester.tap(find.text('运营概览'));
    await tester.pump();

    expect(find.byIcon(Icons.dashboard), findsWidgets);
  });
}