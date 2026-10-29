import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ApiDemoApp());
}

class ApiDemoApp extends StatelessWidget {
  const ApiDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 9 - REST API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
        useMaterial3: true,
      ),
      home: const ShipmentApiScreen(),
    );
  }
}

class ShipmentApiScreen extends StatefulWidget {
  const ShipmentApiScreen({super.key});

  @override
  State<ShipmentApiScreen> createState() => _ShipmentApiScreenState();
}

class _ShipmentApiScreenState extends State<ShipmentApiScreen> {
  late Future<List<ShipmentRecord>> shipments;

  @override
  void initState() {
    super.initState();
    shipments = fetchShipments();
  }

  Future<List<ShipmentRecord>> fetchShipments() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums?_limit=10'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Server returned ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .map((json) => ShipmentRecord.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  void retry() {
    setState(() {
      shipments = fetchShipments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 9 - REST API'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Refresh data',
            onPressed: retry,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<ShipmentRecord>>(
        future: shipments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Loading live shipment data...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    const Text(
                      'Failed to load shipment data. Check connection and retry.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final list = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE3F2FD),
                    child: Text(
                      '#${item.id}',
                      style: const TextStyle(
                        color: Color(0xFF1769AA),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    'Consignment: ${item.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Carrier Hub ID: HUB-${item.userId} · Verified'),
                  trailing: const Icon(Icons.local_shipping_outlined, color: Color(0xFF1769AA)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShipmentRecord {
  final int userId;
  final int id;
  final String title;

  const ShipmentRecord({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory ShipmentRecord.fromJson(Map<String, dynamic> json) {
    return ShipmentRecord(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
