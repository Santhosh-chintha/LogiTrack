
void main() {
  // 1. Variables and data types
  String appName = 'LogiTrack';
  int totalShipments = 3;
  double deliveryCharge = 149.50;
  bool isServiceAvailable = true;

  print('===== $appName: Dart Basics =====');
  print('Total shipments: $totalShipments');
  print('Delivery charge: Rs. $deliveryCharge');
  print('Service available: $isServiceAvailable');

  // 2. List: store shipment IDs
  List<String> shipmentIds = ['LT1001', 'LT1002', 'LT1003'];

  print('\nShipment IDs:');
  for (String id in shipmentIds) {
    print('- $id');
  }

  // 3. Map: store shipment information
  Map<String, String> shipmentInfo = {
    'LT1001': 'In Transit',
    'LT1002': 'Delivered',
    'LT1003': 'Pending',
  };

  print('\nShipment Statuses:');
  shipmentInfo.forEach((id, status) {
    print('$id -> $status');
  });

  // 4. Create objects using a custom class
  Shipment shipment = Shipment(
    id: 'LT1004',
    recipient: 'Rahul',
    destination: 'Hyderabad',
    status: 'Pending',
  );

  print('\nNew Shipment:');
  shipment.displayDetails();

  // 5. Call a function
  double charge = calculateDeliveryCharge(5.5, 20.0);
  print('\nCalculated delivery charge: Rs. $charge');

  // 6. Conditional statement
  if (isServiceAvailable) {
    print('LogiTrack delivery service is active.');
  } else {
    print('LogiTrack delivery service is unavailable.');
  }
}

// A function that calculates the delivery charge.
double calculateDeliveryCharge(double distanceKm, double ratePerKm) {
  return distanceKm * ratePerKm;
}

// A class representing a shipment.
class Shipment {
  String id;
  String recipient;
  String destination;
  String status;

  Shipment({
    required this.id,
    required this.recipient,
    required this.destination,
    required this.status,
  });

  void displayDetails() {
    print('Shipment ID: $id');
    print('Recipient: $recipient');
    print('Destination: $destination');
    print('Status: $status');
  }
}
