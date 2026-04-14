import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<dynamic> customers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/customers'),
      );

      if (response.statusCode == 200) {
        setState(() {
          customers = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        print('Lỗi API');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  void deleteCustomer(String id) async {
    await http.delete(
      Uri.parse('http://localhost:3000/api/customers/$id'),
    );
    fetchCustomers();
  }

  void showAddDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Thêm khách hàng"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Tên"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "SĐT"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await http.post(
                Uri.parse('http://localhost:3000/api/customers'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  "ten_kh": nameController.text,
                  "sdt": phoneController.text,
                }),
              );

              Navigator.pop(context);
              fetchCustomers();
            },
            child: const Text("Lưu"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddDialog,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final c = customers[index];

                return ListTile(
                  title: Text(c['ten_kh'] ?? ''),
                  subtitle: Text(c['sdt'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteCustomer(c['ma_kh']),
                  ),
                );
              },
            ),
    );
  }
}