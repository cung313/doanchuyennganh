// lib/models/order.dart
class Order {
  final String id;
  final String customerId;
  final DateTime date;
  final double total;

  Order({required this.id, required this.customerId, required this.date, required this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      date: DateTime.parse(json['date']),
      total: json['total'],
    );
  }
}