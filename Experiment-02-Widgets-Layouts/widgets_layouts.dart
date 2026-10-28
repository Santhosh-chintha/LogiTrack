import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetsLayoutsDemo());
}

class WidgetsLayoutsDemo extends StatelessWidget {
  const WidgetsLayoutsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 2 - Widgets and Layouts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WidgetsLayoutsScreen(),
    );
  }
}

class WidgetsLayoutsScreen extends StatelessWidget {
  const WidgetsLayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 2: Flutter Widgets'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LogiTrack Widget Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('This screen demonstrates basic Flutter widgets.'),
            const SizedBox(height: 20),

            // Container and Icon widgets
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_shipping, size: 40, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Shipment Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Row Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.inventory_2, size: 35, color: Colors.blue),
                Icon(Icons.local_shipping, size: 35, color: Colors.orange),
                Icon(Icons.check_circle, size: 35, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Column Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipment: LT1001'),
                Text('Customer: Rahul Sharma'),
                Text('Destination: Hyderabad'),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Stack Layout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const Icon(Icons.warehouse, size: 55, color: Colors.blue),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Image widget with a fallback if internet is unavailable
            const Text(
              'Image Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.network(
              'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 45),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
