import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'products_screen.dart';
import 'customers_screen.dart';
import 'inventory_screen.dart';
import 'order_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SAMCO Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Customers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomersScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Inventory'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to SAMCO Admin Dashboard',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}