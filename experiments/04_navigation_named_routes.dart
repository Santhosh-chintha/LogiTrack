import 'package:flutter/material.dart';

void main() => runApp(const LogiTrackApp());

// Centralized route names keep navigation easy to maintain.
class AppRoutes {
  static const dashboard = '/';
  static const details = '/details';
  static const fleet = '/fleet';
}

class LogiTrackApp extends StatelessWidget {
  const LogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogiTrack Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.dashboard,
      routes: {
        AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.details: (context) => const ShipmentDetailsScreen(),
        AppRoutes.fleet: (context) => const FleetScreen(),
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogiTrack Navigation'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFF1769AA),
              child: Icon(Icons.local_shipping, size: 42, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'LogiTrack Hub Dispatch',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text('Central Delivery & Logistics Router'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.details),
              child: const Text('View Shipment Details'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.fleet),
              child: const Text('View Fleet & Hubs'),
            ),
          ],
        ),
      ),
    );
  }
}

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipment Details'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Consignment Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Tracking ID: LT1001'),
            Text('Origin: Mumbai Central Hub'),
            Text('Destination: Hyderabad, Telangana'),
            Text('Current Status: In Transit'),
            SizedBox(height: 24),
            Text('Use the AppBar back button to return to the dashboard.'),
          ],
        ),
      ),
    );
  }
}

class FleetScreen extends StatelessWidget {
  const FleetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logistics Fleet & Hubs'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          ListTile(leading: Icon(Icons.local_shipping), title: Text('Express Delivery Vans')),
          ListTile(leading: Icon(Icons.flight_takeoff), title: Text('Air Cargo Network')),
          ListTile(leading: Icon(Icons.warehouse), title: Text('Regional Warehouses & Sorting Hubs')),
        ],
      ),
    );
  }
}
