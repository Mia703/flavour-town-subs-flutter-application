import 'package:flavour_town_subs_flutter_application/pages/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ================== PRODUCTS GRID ==================
// ONLY DISPLAYS MENU ITEMS THAT ARE 'COLD'
class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchProducts();
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final data = await supabase.from('products').select('*').filter('product_type', 'eq', 'cold');

    if (data.isEmpty) {
      throw Exception('data is empty');
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data'));
        } else {
          final products = snapshot.data!;
          return ListView(
            scrollDirection: Axis.horizontal,
            children: products.map((pr) {
              return ProductWidget(
                  productName: pr['product_name'],
                  productDescription: pr['product_desc'],
                  productPrice: pr['product_price'],
                  productImage: pr['product_image']);
            }).toList(),
          );
        }
      },
    );
  }
}
