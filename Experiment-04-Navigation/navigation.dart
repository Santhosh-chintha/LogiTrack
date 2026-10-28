import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationExperimentApp());
}

class NavigationExperimentApp extends StatelessWidget {
  const NavigationExperimentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 4 - Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/shipments': (context) => const ShipmentsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogiTrack Home'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_shipping, size: 80, color: Colors.blue.shade700),
              const SizedBox(height: 20),
              const Text(
                'Welcome to LogiTrack',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Navigate between screens using named routes.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/shipments');
                  },
                  icon: const Icon(Icons.inventory_2),
                  label: const Text('View Shipments'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('View Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShipmentsScreen extends StatelessWidget {
  const ShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipments'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ShipmentTile(
            trackingId: 'LT1001',
            destination: 'Hyderabad',
            status: 'In Transit',
            icon: Icons.local_shipping,
            color: Colors.orange,
          ),
          ShipmentTile(
            trackingId: 'LT1002',
            destination: 'Warangal',
            status: 'Delivered',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          ShipmentTile(
            trackingId: 'LT1003',
            destination: 'Vijayawada',
            status: 'Pending',
            icon: Icons.pending_actions,
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          BackToHomeButton(),
        ],
      ),
    );
  }
}

class ShipmentTile extends StatelessWidget {
  final String trackingId;
  final String destination;
  final String status;
  final IconData icon;
  final Color color;

  const ShipmentTile({
    super.key,
    required this.trackingId,
    required this.destination,
    required this.status,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          trackingId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$destination • $status'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.person, size: 55, color: Colors.blue.shade800),
            ),
            const SizedBox(height: 16),
            const Text(
              'LogiTrack User',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Delivery Management'),
            const SizedBox(height: 24),
            const BackToHomeButton(),
          ],
        ),
      ),
    );
  }
}

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      },
      icon: const Icon(Icons.home),
      label: const Text('Back to Home'),
    );
  }
}
