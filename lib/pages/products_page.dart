import 'package:flutter/material.dart';

// ================== PRODUCTS PAGE ==================
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // List of items in our dropdown menu
  var items = [
    'Hot Subs',
    'Cold Subs',
    'Sides, Drinks, and Desserts',
  ];

  // Initial Selected Value
  String dropdownValue = 'Hot Subs';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('list of product items goes here'),
      ),
    );
  }
}
