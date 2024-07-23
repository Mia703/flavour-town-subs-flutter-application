import 'package:flavour_town_subs_flutter_application/database/database.dart';
import 'package:flavour_town_subs_flutter_application/database/db_schema/products_model.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ================== PRODUCTS PAGE ==================
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = FlutterDatabase.instance.readAllProducts();
  }

  @override
  void dispose() {
    FlutterDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: primaryPaddingAll,
          child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: paragraph),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found.',
                      style: TextStyle(fontSize: paragraph),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final Product product = snapshot.data![index];
                        return ListTile(
                          title: Text(product.productName),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
