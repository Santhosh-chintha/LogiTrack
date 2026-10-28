import 'package:flutter/material.dart';

void main() {
  runApp(const CustomWidgetsApp());
}

class CustomWidgetsApp extends StatelessWidget {
  const CustomWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Widgets Experiment',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        cardTheme: CardThemeData(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const CustomWidgetsScreen(),
    );
  }
}

class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogiTrack Components')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Reusable Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text('Experiment 6: Themes and Styling'),
          SizedBox(height: 20),
          ShipmentCard(
            title: 'Total Shipments',
            value: '128',
            icon: Icons.inventory_2,
            color: Colors.indigo,
          ),
          ShipmentCard(
            title: 'In Transit',
            value: '42',
            icon: Icons.local_shipping,
            color: Colors.orange,
          ),
          ShipmentCard(
            title: 'Delivered',
            value: '86',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          SectionTitle(title: 'Quick Actions'),
          SizedBox(height: 12),
          QuickActionButton(label: 'Add Shipment', icon: Icons.add_box),
          SizedBox(height: 10),
          QuickActionButton(label: 'View Reports', icon: Icons.bar_chart),
        ],
      ),
    );
  }
}

class ShipmentCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ShipmentCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const QuickActionButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$label selected')));
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
