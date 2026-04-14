// lib/screens/order_screen.dart
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
    const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Screen')),
      body: Center(
        child: Text('Place your order here'),
      ),
    );
  }
}