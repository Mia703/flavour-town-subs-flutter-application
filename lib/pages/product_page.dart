import 'package:flavour_town_subs_flutter_application/components/product_detail_.dart';
import 'package:flavour_town_subs_flutter_application/components/product_slider.dart';
import 'package:flavour_town_subs_flutter_application/pages/account_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/cart_page.dart';
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
                margin: addMargin('bottom', 75.00),
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
                padding: addPadding('tb', 6.00) + addPadding('lr', 5.00),
                decoration: BoxDecoration(
                  color: primaryColourYellow,
                  borderRadius: addBorderRadius('default', 2000.00),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ================= MENU BUTTON
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductPage()));
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.fastfood,
                            size: headerTwo,
                            color: primaryColourBlack,
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(
                                fontSize: paragraph - 5,
                                color: primaryColourBlack),
                          ),
                        ],
                      ),
                    ),
                    // ================= CART BUTTON
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartPage()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Badge(
                            label: Text('${currentOrder.getOrderCount()}'),
                            backgroundColor: primaryColourRed,
                            textColor: primaryColourWhite,
                            child: const Icon(
                              Icons.shopping_bag,
                              size: headerTwo,
                              color: primaryColourBlack,
                            ),
                          ),
                          const Text(
                            'Cart',
                            style: TextStyle(
                                fontSize: paragraph - 5,
                                color: primaryColourBlack),
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
                            color: primaryColourBlack,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                                fontSize: paragraph - 5,
                                color: primaryColourBlack),
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
