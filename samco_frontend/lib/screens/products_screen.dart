// lib/screens/products_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
      const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];

  Future<void> fetchProducts() async {
    final url = 'http://localhost:3000/api/products';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _products = data.map((item) => Product.fromJson(item)).toList();
      });
    } else {
      print('Failed to fetch products');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(_products[index].name),
            subtitle: Text('Price: \$${_products[index].price}'),
          );
        },
      ),
    );
  }
}