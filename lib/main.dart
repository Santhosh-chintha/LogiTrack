
import 'package:flutter/material.dart';

void main() {
  runApp(const LogiTrackApp());
}

class LogiTrackApp extends StatelessWidget {
  const LogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogiTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1769AA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.local_shipping, size: 30),
            SizedBox(width: 10),
            Text(
              'LogiTrack',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183153),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Here is your delivery overview.',
                style: TextStyle(color: Colors.blueGrey, fontSize: 15),
              ),
              const SizedBox(height: 20),

              // Image widget with a fallback if the network is unavailable
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d'
                  '?auto=format&fit=crop&w=1000&q=80',
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 145,
                      width: double.infinity,
                      color: const Color(0xFFDCEBFA),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.warehouse_outlined,
                        size: 65,
                        color: Color(0xFF1769AA),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),

              const Text(
                'Shipment Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Row and Expanded arrange the three summary cards
              const Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Total',
                      count: '24',
                      icon: Icons.inventory_2_outlined,
                      color: Color(0xFF1769AA),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      title: 'In Transit',
                      count: '08',
                      icon: Icons.local_shipping_outlined,
                      color: Color(0xFFE58B19),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(
                      title: 'Delivered',
                      count: '16',
                      icon: Icons.check_circle_outline,
                      color: Color(0xFF20845A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent shipments heading
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Shipments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Color(0xFF1769AA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const ShipmentCard(
                shipmentId: 'LT1001',
                destination: 'Hyderabad, Telangana',
                recipient: 'Rahul Sharma',
                status: 'In Transit',
                statusColor: Color(0xFFE58B19),
                icon: Icons.local_shipping_outlined,
              ),
              const ShipmentCard(
                shipmentId: 'LT1002',
                destination: 'Warangal, Telangana',
                recipient: 'Priya Reddy',
                status: 'Delivered',
                statusColor: Color(0xFF20845A),
                icon: Icons.check_circle_outline,
              ),
              const ShipmentCard(
                shipmentId: 'LT1003',
                destination: 'Vijayawada, Andhra Pradesh',
                recipient: 'Arjun Kumar',
                status: 'Pending',
                statusColor: Color(0xFF1769AA),
                icon: Icons.schedule,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable summary card built with Container, Column, Icon and Text.
class SummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 27),
          const SizedBox(height: 9),
          Text(
            count,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable shipment card. Stack and Positioned display the status indicator.
class ShipmentCard extends StatelessWidget {
  final String shipmentId;
  final String destination;
  final String recipient;
  final String status;
  final Color statusColor;
  final IconData icon;

  const ShipmentCard({
    super.key,
    required this.shipmentId,
    required this.destination,
    required this.recipient,
    required this.status,
    required this.statusColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: statusColor, size: 29),
                ),
                Positioned(
                  right: -3,
                  top: -3,
                  child: Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shipmentId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipient,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    destination,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
