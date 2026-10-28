import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'testing_debugging.dart' as app;

void main() {
  testWidgets('Dashboard displays the initial shipment count', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const app.TestingDebuggingApp());

    expect(find.text('Testing Dashboard'), findsOneWidget);
    expect(find.text('Total Shipments: 0'), findsOneWidget);
  });

  testWidgets('Adding a shipment increases the count', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const app.TestingDebuggingApp());

    await tester.tap(find.byKey(const Key('addShipmentButton')));
    await tester.pump();

    expect(find.text('Total Shipments: 1'), findsOneWidget);
  });

  testWidgets('Reset button returns the count to zero', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const app.TestingDebuggingApp());

    await tester.tap(find.byKey(const Key('addShipmentButton')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('resetButton')));
    await tester.pump();

    expect(find.text('Total Shipments: 0'), findsOneWidget);
  });
}
