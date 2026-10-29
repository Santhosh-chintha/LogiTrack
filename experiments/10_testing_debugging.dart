import 'package:flutter/material.dart';

/// Experiment 10: Testing and Debugging in Flutter.
///
/// Run this file directly to view a checklist of widget testing and debugging
/// tools. Automated UI tests are maintained in test/exp10_testing_debugging_test.dart.
void main() => runApp(const Experiment10App());

class Experiment10App extends StatelessWidget {
  const Experiment10App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Experiment 10 - Testing & Debugging',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
          useMaterial3: true,
        ),
        home: const Experiment10Screen(),
      );
}

class Experiment10Screen extends StatelessWidget {
  const Experiment10Screen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Experiment 10 - Testing & Debugging'),
          backgroundColor: const Color(0xFF1769AA),
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Text(
              'A. Write UI Widget Tests',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.verified),
              title: Text('Test visible text'),
              subtitle: Text('Pump the widget and verify expected labels with find.text().'),
            ),
            ListTile(
              leading: Icon(Icons.touch_app),
              title: Text('Test user interaction'),
              subtitle: Text('Tap buttons, enter form values, and verify the resulting UI.'),
            ),
            ListTile(
              leading: Icon(Icons.fact_check),
              title: Text('Test validation'),
              subtitle: Text('Submit invalid data and check that validation messages appear.'),
            ),
            Divider(height: 32),
            Text(
              'B. Flutter Debugging Tools',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.account_tree),
              title: Text('Flutter Inspector'),
              subtitle: Text('Inspect widget hierarchy, constraints, padding, and alignment.'),
            ),
            ListTile(
              leading: Icon(Icons.speed),
              title: Text('Flutter DevTools'),
              subtitle: Text('Investigate performance, memory, and widget rebuild behavior.'),
            ),
            ListTile(
              leading: Icon(Icons.pause_circle),
              title: Text('IDE debugger and breakpoints'),
              subtitle: Text('Pause execution and inspect variables and the call stack.'),
            ),
            ListTile(
              leading: Icon(Icons.terminal),
              title: Text('Console logs and exceptions'),
              subtitle: Text('Use debugPrint() and stack traces to narrow down failures.'),
            ),
            Divider(height: 32),
            Text(
              'Verification Commands',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('flutter analyze'),
              subtitle: Text('Checks code for analyzer and lint issues.'),
            ),
            ListTile(
              title: Text('flutter test'),
              subtitle: Text('Runs unit and widget tests.'),
            ),
            ListTile(
              title: Text('flutter run --debug'),
              subtitle: Text('Runs the app in debug mode for investigation.'),
            ),
          ],
        ),
      );
}
