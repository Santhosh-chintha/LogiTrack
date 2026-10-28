import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveLogiTrackApp());
}

class ResponsiveLogiTrackApp extends StatelessWidget {
  const ResponsiveLogiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 3 - Responsive UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ResponsiveDashboard(),
    );
  }
}

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery obtains the screen width.
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_shipping),
            SizedBox(width: 10),
            Text('LogiTrack'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // LayoutBuilder obtains the available content width.
          final availableWidth = constraints.maxWidth;

          final columns = availableWidth < 500
              ? 1
              : availableWidth < 850
              ? 2
              : 3;

          const spacing = 12.0;
          final cardWidth =
              (availableWidth - spacing * (columns - 1)) / columns;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Responsive Dashboard',
                      style: TextStyle(
                        fontSize: isMobile ? 23 : 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Screen type: ${isMobile
                          ? "Mobile"
                          : isTablet
                          ? "Tablet"
                          : "Desktop"}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Banner adjusts its height for smaller screens.
                    Container(
                      height: isMobile ? 120 : 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade800,
                            Colors.lightBlue.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(isMobile ? 16 : 26),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Manage Deliveries',
                                  style: TextStyle(
                                    fontSize: isMobile ? 20 : 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isMobile ? 'Track shipments easily' : 'Track shipments and monitor delivery status',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isMobile)
                            const Icon(
                              Icons.local_shipping,
                              color: Colors.white,
                              size: 65,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),

                    const Text(
                      'Shipment Overview',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Cards automatically change columns with screen width.
                    Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: const ResponsiveSummaryCard(
                            title: 'Total Shipments',
                            value: '24',
                            icon: Icons.inventory_2_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const ResponsiveSummaryCard(
                            title: 'In Transit',
                            value: '08',
                            icon: Icons.local_shipping_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const ResponsiveSummaryCard(
                            title: 'Delivered',
                            value: '16',
                            icon: Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),

                    const Text(
                      'Recent Shipments',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const ResponsiveShipmentCard(
                      id: 'LT1001',
                      customer: 'Rahul Sharma',
                      destination: 'Hyderabad',
                      status: 'In Transit',
                      color: Colors.orange,
                    ),
                    const ResponsiveShipmentCard(
                      id: 'LT1002',
                      customer: 'Priya Reddy',
                      destination: 'Warangal',
                      status: 'Delivered',
                      color: Colors.green,
                    ),
                    const ResponsiveShipmentCard(
                      id: 'LT1003',
                      customer: 'Arjun Kumar',
                      destination: 'Vijayawada',
                      status: 'Pending',
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: Text(
                        'LogiTrack | Responsive UI Experiment',
                        style: TextStyle(
                          color: Colors.blueGrey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResponsiveSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ResponsiveSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class ResponsiveShipmentCard extends StatelessWidget {
  final String id;
  final String customer;
  final String destination;
  final String status;
  final Color color;

  const ResponsiveShipmentCard({
    super.key,
    required this.id,
    required this.customer,
    required this.destination,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 18),
        child: Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: isMobile ? 30 : 38,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('$customer • $destination'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
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
