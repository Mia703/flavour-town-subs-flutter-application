import 'package:flavour_town_subs_flutter_application/components/product_page/product_button.dart';
import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key, required this.header, required this.type});

  final String header;
  final String type;

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  late Future<List<Map<String, dynamic>>> _productsList;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _productsList = getProductsByType(supabase, widget.type);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: addMargin('default', 16.00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= PRODUCT TYPE HEADER =================
          Text(
            widget.header,
            style: const TextStyle(
              fontSize: headerTwo,
              fontWeight: bold,
              fontStyle: italic,
            ),
          ),
          addSpacer('height', 10.00),
          // ================= PRODUCT SLIDER BUILDER =================
          FutureBuilder(
              future: _productsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Error: There is no data'),
                  );
                } else {
                  // ================= PRODUCT SLIDER CONTAINER
                  final List<Map<String, dynamic>> products = snapshot.data!;
                  return SizedBox(
                    // changes height of slider box
                    height: 300.00,
                    width: double.infinity,
                    // ================= LIST VIEW
                    child: ListView.builder(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // ================= PRODUCT BUTTON
                        final product = snapshot.data![index];
                        return ProductButton(
                          id: product['product_id'],
                          name: product['product_name'],
                          description: product['product_desc'],
                          price: '${product['product_price']}',
                          image: product['product_image'],
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
