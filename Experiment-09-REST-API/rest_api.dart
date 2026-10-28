import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const RestApiApp());
}

class RestApiApp extends StatelessWidget {
  const RestApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogiTrack API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ShipmentsApiScreen(),
    );
  }
}

class Shipment {
  final int id;
  final String title;
  final String description;

  const Shipment({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['body'] as String,
    );
  }
}

Future<List<Shipment>> fetchShipments() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'))
      .timeout(const Duration(seconds: 15));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data
        .map((item) => Shipment.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  throw Exception('Server returned status ${response.statusCode}');
}

class ShipmentsApiScreen extends StatefulWidget {
  const ShipmentsApiScreen({super.key});

  @override
  State<ShipmentsApiScreen> createState() => _ShipmentsApiScreenState();
}

class _ShipmentsApiScreenState extends State<ShipmentsApiScreen> {
  late Future<List<Shipment>> _shipmentsFuture;

  @override
  void initState() {
    super.initState();
    _shipmentsFuture = fetchShipments();
  }

  void _retry() {
    setState(() {
      _shipmentsFuture = fetchShipments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogiTrack - API Shipments'),
        actions: [
          IconButton(
            onPressed: _retry,
            tooltip: 'Refresh data',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Shipment>>(
        future: _shipmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Fetching shipment data...'),
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
                    const Icon(Icons.cloud_off, size: 56, color: Colors.red),
                    const SizedBox(height: 12),
                    const Text(
                      'Unable to load data',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check your internet connection and try again.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final shipments = snapshot.data ?? [];

          if (shipments.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.cloud_download, size: 36),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Data fetched successfully from a REST API',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Sample Records: ${shipments.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...shipments.map(
                (shipment) => Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${shipment.id}')),
                    title: Text(
                      shipment.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      shipment.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
