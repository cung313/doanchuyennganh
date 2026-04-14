import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
    const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = [];

  Future<void> fetchCategories() async {
    final url = 'http://localhost:3000/api/categories';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _categories = data.map((item) => Category.fromJson(item)).toList();
      });
    } else {
      print('Failed to fetch categories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(_categories[index].name),
          );
        },
      ),
    );
  }
}