// lib/screens/inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InventoryScreen extends StatefulWidget {
    const InventoryScreen({super.key});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // Inventory related data
  List<dynamic> _inventory = [];

  Future<void> fetchInventory() async {
    final url = 'http://localhost:3000/api/inventory';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _inventory = jsonDecode(response.body);
      });
    } else {
      print('Failed to fetch inventory');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: ListView.builder(
        itemCount: _inventory.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(_inventory[index]['product_name']),
            subtitle: Text('Stock: ${_inventory[index]['stock']}'),
          );
        },
      ),
    );
  }
}