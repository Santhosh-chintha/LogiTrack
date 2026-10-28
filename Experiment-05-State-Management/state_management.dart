
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ShipmentProvider(),
      child: const StateManagementApp(),
    ),
  );
}

// Provider manages shipment data shared across widgets.
class ShipmentProvider extends ChangeNotifier {
  int deliveredCount = 16;

  void markDelivered() {
    deliveredCount++;
    notifyListeners();
  }
}

class StateManagementApp extends StatelessWidget {
  const StateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 5 - State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const StateManagementScreen(),
    );
  }
}

// StatefulWidget manages the local counter using setState().
class StateManagementScreen extends StatefulWidget {
  const StateManagementScreen({super.key});

  @override
  State<StateManagementScreen> createState() =>
      _StateManagementScreenState();
}

class _StateManagementScreenState extends State<StateManagementScreen> {
  int localCounter = 0;

  @override
  Widget build(BuildContext context) {
    final shipmentProvider = context.watch<ShipmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LogiTrack State Management'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.local_shipping,
              size: 70,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            const Text(
              'State Management Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Example 1: Local state managed with setState().
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      '1. Local State using setState()',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Button clicks: $localCounter',
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          localCounter++;
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Increment Counter'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Example 2: Shared state managed with Provider.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      '2. Shared State using Provider',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.check_circle,
                      size: 42,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Delivered Shipments: '
                      '${shipmentProvider.deliveredCount}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: shipmentProvider.markDelivered,
                      icon: const Icon(Icons.done_all),
                      label: const Text('Mark One Delivered'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Experiment result: Both local and shared state '
              'update the UI when their values change.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
