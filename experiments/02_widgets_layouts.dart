import 'package:flutter/material.dart';

// Experiment 2: Explore Flutter widgets and layout using Row, Column and Stack.
void main() {
  runApp(const LogiTrackApp());
}

class LogiTrackApp extends StatelessWidget {
  const LogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LogiTrack - Shipment Overview'),
          backgroundColor: const Color(0xFF1769AA),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          // Column arranges the main shipment sections vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack places the delivery status avatar over the banner.
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade100,
                    ),
                    child: const Center(
                      child: Icon(Icons.local_shipping, size: 70, color: Color(0xFF1769AA)),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF1769AA),
                    child: Icon(Icons.inventory_2, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Shipment Batch #LT1000',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Express Logistics | Regional Distribution Center'),
              const SizedBox(height: 20),
              // Row displays the shipment statistics horizontally.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _InfoItem(icon: Icons.inventory_2_outlined, label: '24 Total'),
                  _InfoItem(icon: Icons.local_shipping_outlined, label: '08 In Transit'),
                  _InfoItem(icon: Icons.check_circle_outline, label: '16 Delivered'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1769AA)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
