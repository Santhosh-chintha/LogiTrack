import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logitrack/main.dart';

void main() {
  group('Experiment 10 - UI widget tests', () {
    testWidgets('ShipmentHeader displays the shipment ID and destination',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ShipmentHeader(
              title: 'LT1001',
              subtitle: 'Hyderabad Central Hub',
            ),
          ),
        ),
      );

      expect(find.text('LT1001'), findsOneWidget);
      expect(find.text('Hyderabad Central Hub'), findsOneWidget);
    });

    testWidgets('Shipment form shows validation messages when submitted empty',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ShipmentFormScreen()),
      );

      await tester.ensureVisible(find.text('Submit'));
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter sender name'), findsOneWidget);
      expect(find.text('Please enter email'), findsOneWidget);
      expect(find.text('Please enter phone number'), findsOneWidget);
      expect(find.text('Please enter destination address'), findsOneWidget);
    });

    testWidgets('Experiment 10 card opens the testing and debugging screen',
        (tester) async {
      await tester.pumpWidget(const LogiTrackApp());

      final experiment10 = find.text('Experiment 10 - Testing & Debugging');
      await tester.scrollUntilVisible(
        experiment10,
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(experiment10);
      await tester.pumpAndSettle();

      expect(find.text('Flutter Debugging Tools'), findsOneWidget);
      final analyzeCommand = find.text('flutter analyze');
      await tester.scrollUntilVisible(
        analyzeCommand,
        250,
        scrollable: find.byType(Scrollable).last,
      );
      expect(analyzeCommand, findsOneWidget);
      expect(find.text('flutter test'), findsOneWidget);
    });
  });
}
