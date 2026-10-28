import 'package:flutter/material.dart';

void main() {
  runApp(const TestingDebuggingApp());
}

class TestingDebuggingApp extends StatelessWidget {
  const TestingDebuggingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TestingDashboard(),
    );
  }
}

class TestingDashboard extends StatefulWidget {
  const TestingDashboard({super.key});

  @override
  State<TestingDashboard> createState() => _TestingDashboardState();
}

class _TestingDashboardState extends State<TestingDashboard> {
  int _shipmentCount = 0;

  void _addShipment() {
    setState(() {
      _shipmentCount++;
    });
  }

  void _resetShipments() {
    setState(() {
      _shipmentCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Dashboard')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inventory_2, size: 64, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text(
                'Shipment Counter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Total Shipments: $_shipmentCount',
                key: const Key('shipmentCount'),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                key: const Key('addShipmentButton'),
                onPressed: _addShipment,
                icon: const Icon(Icons.add),
                label: const Text('Add Shipment'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                key: const Key('resetButton'),
                onPressed: _resetShipments,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
