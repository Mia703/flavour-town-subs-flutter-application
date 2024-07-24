import 'package:flavour_town_subs_flutter_application/components/products_slider.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ================== PRODUCT PAGE ==================
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColourWhite,
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  color: primaryColourLightGrey,
                  padding: primaryPaddingAll,
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Menu',
                      style: TextStyle(fontSize: headerThree),
                    ),
                  ),
                ),
                Container(
                  padding: primaryPaddingAll,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hot Subs',
                        style: TextStyle(fontSize: headerTwo),
                      ),
                      // ================== hot menu slider
                      Container(
                        padding: primaryPaddingAll,
                        child: const ProductsSlider(type: 'hot'),
                      ),
                      const Text(
                        'Cold Subs',
                        style: TextStyle(fontSize: headerTwo),
                      ),
                      // ================== cold menu slider
                      Container(
                        padding: primaryPaddingAll,
                        child: const ProductsSlider(type: 'cold'),
                      ),
                      const Text(
                        'Sides, Drinks, and Desserts',
                        style: TextStyle(fontSize: headerTwo),
                      ),
                      // ================== sides, drinks, desserts
                      Container(
                        padding: primaryPaddingAll,
                        child: const ProductsSlider(type: 'side'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: primaryPaddingAll,
                margin: primaryMarginAll,
                decoration: const BoxDecoration(
                  color: primaryColourMediumGrey,
                  borderRadius: BorderRadius.all(
                      Radius.circular(primaryRadiusNumber * 4)),
                ),
                height: 80.0,
                width: double.infinity,
                child: Container(
                  padding: primaryMarginLeftRight * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ================== menu button
                      MaterialButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.fastfood,
                          size: headerOne,
                        ),
                      ),
                      // ================== cart button
                      MaterialButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.shopping_cart,
                          size: headerOne,
                        ),
                      ),
                      // ================== account
                      MaterialButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.account_circle,
                          size: headerOne,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
