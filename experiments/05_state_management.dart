import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
    }
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 5 - State Management'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LogiTrack Dispatch Portal',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Dispatched Shipment Count', style: TextStyle(fontSize: 22)),
            Text(
              '${counter.count}',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1769AA),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: counter.increment,
              child: const Text('Increase'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: counter.decrement,
              child: const Text('Decrease'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: counter.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
