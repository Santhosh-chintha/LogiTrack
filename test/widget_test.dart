import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logitrack/main.dart';

void main() {
  testWidgets('LogiTrack App opens and lists Experiment 9', (tester) async {
    await tester.pumpWidget(const LogiTrackApp());

    expect(find.text('LogiTrack'), findsWidgets);

    final experiment9 = find.text('Experiment 9 - REST API');
    await tester.scrollUntilVisible(
      experiment9,
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(experiment9, findsOneWidget);
  });
}
