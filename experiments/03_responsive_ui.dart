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
      title: 'LogiTrack Responsive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
      ),
      home: const ResponsiveLogisticsPage(),
    );
  }
}

class ResponsiveLogisticsPage extends StatelessWidget {
  const ResponsiveLogisticsPage({super.key});

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    // Read the current screen width using MediaQuery.
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= desktopBreakpoint;
    final isTablet = width >= tabletBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LogiTrack - Responsive Dispatch'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 16),
            // Desktop uses two columns; smaller screens use a scrollable list.
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _ShipmentCard(isTablet: true)),
                      const SizedBox(width: 24),
                      Expanded(child: _DetailsCard(isTablet: true)),
                    ],
                  )
                : ListView(
                    children: [
                      _ShipmentCard(isTablet: isTablet),
                      const SizedBox(height: 16),
                      _DetailsCard(isTablet: isTablet),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _ShipmentCard extends StatelessWidget {
  final bool isTablet;

  const _ShipmentCard({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 28 : 20),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF1769AA),
              child: Icon(Icons.local_shipping, size: 48, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Consignment #LT1001',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('Hyderabad Logistics Hub · In Transit'),
          ],
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final bool isTablet;

  const _DetailsCard({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 28 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Delivery Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 14),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Recipient'),
              trailing: Text('Rahul Sharma'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Destination'),
              trailing: Text('Hyderabad, Telangana'),
            ),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Shipment Status'),
              trailing: Text('In Transit'),
            ),
          ],
        ),
      ),
    );
  }
}
