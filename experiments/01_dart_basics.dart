// Experiment 1(b): Simple Dart program to understand language basics.
// Covers variables, primitive data types, arithmetic, string interpolation,
// and a basic if/else decision for LogiTrack logistics management.

void main() {
  // Dart variable examples.
  String shipmentId = 'LT1001';
  int packageCount = 24;
  double deliveryWeightKg = 8.5;
  bool isDelivered = false;

  print('LogiTrack Shipment Profile');
  print('Shipment ID: $shipmentId');
  print('Package Count: $packageCount');
  print('Weight: ${deliveryWeightKg}kg');
  print('Delivered: $isDelivered');

  // Basic arithmetic operations.
  int standardCharge = 85;
  int expressFee = 90;
  int totalCharge = standardCharge + expressFee;
  double averageRate = totalCharge / 2;

  print('Total Delivery Charge: Rs. $totalCharge');
  print('Average Rate: Rs. $averageRate');

  // Basic conditional statement.
  if (totalCharge >= 150) {
    print('Status: Express Priority Delivery');
  } else {
    print('Status: Standard Delivery');
  }
}
