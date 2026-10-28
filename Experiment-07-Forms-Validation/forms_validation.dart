import 'package:flutter/material.dart';

void main() {
  runApp(const FormsValidationApp());
}

class FormsValidationApp extends StatelessWidget {
  const FormsValidationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ShipmentFormScreen(),
    );
  }
}

class ShipmentFormScreen extends StatefulWidget {
  const ShipmentFormScreen({super.key});

  @override
  State<ShipmentFormScreen> createState() => _ShipmentFormScreenState();
}

class _ShipmentFormScreenState extends State<ShipmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senderController = TextEditingController();
  final _receiverController = TextEditingController();
  final _destinationController = TextEditingController();

  String _shipmentType = 'Standard';

  @override
  void dispose() {
    _senderController.dispose();
    _receiverController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Shipment registered for ${_receiverController.text.trim()}!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Shipment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.local_shipping, size: 64, color: Colors.indigo),
              const SizedBox(height: 12),
              const Text(
                'Shipment Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _senderController,
                decoration: const InputDecoration(
                  labelText: 'Sender Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the sender name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _receiverController,
                decoration: const InputDecoration(
                  labelText: 'Receiver Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the receiver name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a destination';
                  }
                  if (value.trim().length < 3) {
                    return 'Destination must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _shipmentType,
                decoration: const InputDecoration(
                  labelText: 'Shipment Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Standard', child: Text('Standard')),
                  DropdownMenuItem(value: 'Express', child: Text('Express')),
                  DropdownMenuItem(value: 'Fragile', child: Text('Fragile')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _shipmentType = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Register Shipment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
