import 'package:flutter/material.dart';

void main() {
  runApp(const LogiTrackApp());
}

class LogiTrackApp extends StatelessWidget {
  const LogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        cardTheme: const CardThemeData(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      home: const ShipmentScreen(),
    );
  }
}

// Custom widget for a shipment header.
class ShipmentHeader extends StatelessWidget {
  final String shipmentId;
  final String status;

  const ShipmentHeader({
    super.key,
    required this.shipmentId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFF1769AA),
              child: Icon(Icons.local_shipping, size: 35, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shipmentId,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom reusable widget for shipment information.
class ShipmentInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ShipmentInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE3F2FD),
          child: Icon(icon, color: const Color(0xFF1769AA)),
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

// Custom reusable action button.
class DispatchButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DispatchButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.send_rounded),
      label: Text(text),
    );
  }
}

class ShipmentScreen extends StatelessWidget {
  const ShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 6 - Custom Widgets & Themes'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ShipmentHeader(
            shipmentId: 'Shipment #LT1001',
            status: 'Destination: Hyderabad · Priority Express',
          ),
          const ShipmentInfoCard(
            icon: Icons.person_outline,
            title: 'Recipient',
            value: 'Rahul Sharma',
          ),
          const ShipmentInfoCard(
            icon: Icons.location_city_outlined,
            title: 'Hub Location',
            value: 'Telangana Distribution Hub',
          ),
          const ShipmentInfoCard(
            icon: Icons.check_circle_outline,
            title: 'Delivery Status',
            value: 'In Transit (Estimated: Tomorrow 2 PM)',
          ),
          const SizedBox(height: 12),
          DispatchButton(
            text: 'Update Dispatch Status',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Shipment dispatch status refreshed!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
