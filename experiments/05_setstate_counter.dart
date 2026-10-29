import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: PackageCounterScreen(),
));

class PackageCounterScreen extends StatefulWidget {
  const PackageCounterScreen({super.key});

  @override
  State<PackageCounterScreen> createState() => _PackageCounterScreenState();
}

class _PackageCounterScreenState extends State<PackageCounterScreen> {
  int count = 0;

  void change(int value) {
    setState(() => count = value < 0 ? 0 : value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState Dispatch Counter'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dispatched Packages', style: TextStyle(fontSize: 22)),
            Text('$count', style: const TextStyle(
              fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xFF1769AA))),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => change(count + 1),
                child: const Text('Increase')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => change(count - 1),
                child: const Text('Decrease')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => change(0),
                child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
