import 'package:flavour_town_subs_flutter_application/components/product_slider.dart';
import 'package:flavour_town_subs_flutter_application/pages/account_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              // ================= PRODUCT SLIDER CONTAINERS =================
              child: Container(
                margin: addMargin('bottom', 65.00),
                child: const Column(
                  children: <Widget>[
                    ProductSlider(header: 'Hot Subs', type: 'hot'),
                    ProductSlider(header: 'Cold Subs', type: 'cold'),
                    ProductSlider(
                        header: 'Sides, Drinks, and Desserts', type: 'side'),
                  ],
                ),
              ),
            ),
            // ================= BOTTOM MENU CONTAINER =================
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: addMargin('default', 16.00),
                padding: addPadding('default', 5.00) + addPadding('lr', 5.00),
                decoration: BoxDecoration(
                  color: primaryColourDarkGrey,
                  borderRadius: addBorderRadius('default', 2000.00),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ================= MENU BUTTON
                    MaterialButton(
                      onPressed: () {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.fastfood,
                            size: headerTwo,
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(fontSize: paragraph - 5),
                          ),
                        ],
                      ),
                    ),
                    // ================= CART BUTTON
                    MaterialButton(
                      onPressed: () {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: headerTwo,
                          ),
                          Text(
                            'Cart',
                            style: TextStyle(fontSize: paragraph - 5),
                          )
                        ],
                      ),
                    ),
                    // ================= ACCOUNT BUTTON
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountPage()));
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: headerTwo,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(fontSize: paragraph - 5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
