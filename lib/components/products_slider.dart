import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsSlider extends StatefulWidget {
  const ProductsSlider({super.key, required this.type});

  final String type;

  @override
  State<ProductsSlider> createState() => _ProductsSliderState();
}

class _ProductsSliderState extends State<ProductsSlider> {
  final supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchProducts(widget.type);
  }

  Future<List<Map<String, dynamic>>> fetchProducts(String type) async {
    final data = await supabase
        .from('products')
        .select('*')
        .filter('product_type', 'eq', type);

    if (data.isEmpty) {
      throw Exception('Data is empty');
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = 'lib/db/product_images/';
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          } else {
            final products = snapshot.data!;
            return SizedBox(
              height: 330.00,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: products.map((item) {
                  return Container(
                    margin: primaryMarginRight,
                    child: MaterialButton(
                      // TODO: ================== add to cart function
                      onPressed: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ================== image container
                          Container(
                            color: primaryColourLightGrey,
                            child: Image(
                              image:
                                  AssetImage(imagePath + item['product_image']),
                            ),
                          ),
                          // ================== product name
                          Text(
                            item['product_name'],
                            style: const TextStyle(fontSize: headerThree, fontWeight: bold),
                          ),
                          // ================== product price
                          Text(
                            '\$${item['product_price']}',
                            style: const TextStyle(fontSize: headerThree),
                          ),
                          // ================== product description
                          Text(
                            '${item['product_desc']}.',
                            style: const TextStyle(fontSize: paragraph),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}
