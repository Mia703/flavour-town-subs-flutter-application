import 'dart:async';

import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItemsList;
  late Future<double> _cartTotal;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _cartItemsList =
        getCartItems(supabase, currentUser, currentOrder.getOrderId());
    _cartTotal = getCartTotal(supabase, currentUser, currentOrder.getOrderId());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: headerThree,
            fontWeight: bold,
            fontStyle: italic,
          ),
        ),
        backgroundColor: primaryColourWhite,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ================= CART ITEMS BUILDER =================
              FutureBuilder(
                future: _cartItemsList,
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
                      child: Text('You have no items in the cart!'),
                    );
                  } else {
                    final List<Map<String, dynamic>> cartItemsList =
                        snapshot.data!;
                    return ListView.builder(
                      itemCount: cartItemsList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartItemsList[index];
                        final double itemPrice =
                            cartItemsList[index]['item_price'];
                        final String itemPriceString =
                            itemPrice.toStringAsFixed(2);
                        // ================= CART ITEM CONTAINER =================
                        return Container(
                          margin:
                              addMargin('tb', 10.00) + addMargin('lr', 16.00),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ================= cart item name
                              Text(
                                cartItem['product_name'],
                                style: const TextStyle(
                                    fontSize: headerThree,
                                    fontWeight: bold,
                                    fontStyle: italic,
                                    color: primaryColourRed),
                              ),
                              addSpacer('height', 5.00),
                              // ================= cart item description
                              Text(
                                '${cartItem['product_desc']}.',
                                style: const TextStyle(fontSize: paragraph),
                              ),
                              // ================= CART ITEM QUANTITY AND PRICE =================
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // ================= cart item quantity and product price
                                  Text(
                                    '${cartItem['quantity']} x \$${cartItem['product_price']} = ',
                                    style: const TextStyle(
                                      fontSize: paragraph,
                                    ),
                                  ),
                                  // ================= cart item price
                                  Text(
                                    '\$$itemPriceString',
                                    style: const TextStyle(
                                      fontSize: headerThree,
                                      fontWeight: bold,
                                      color: primaryColourBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              // ================= CHECK OUT BUTTON =================
              Padding(
                padding: addPadding('tb', 16.00) + addPadding('lr', 10.00),
                child: FilledButton(
                  onPressed: () {
                    checkout(supabase, context, currentUser, currentOrder);
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(primaryColourYellow),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Check Out',
                        style: TextStyle(
                          fontSize: paragraph,
                          color: primaryColourBlack,
                        ),
                      ),
                      FutureBuilder(
                          future: _cartTotal,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text(
                                  '\$0.00',
                                  style: TextStyle(
                                    fontSize: paragraph,
                                    color: primaryColourBlack,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  '\$0.00',
                                  style: TextStyle(
                                    fontSize: paragraph,
                                    color: primaryColourBlack,
                                  ),
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return const Center(
                                child: Text(
                                  '\$0.00',
                                  style: TextStyle(
                                    fontSize: paragraph,
                                    color: primaryColourBlack,
                                  ),
                                ),
                              );
                            } else {
                              String total = snapshot.data!.toStringAsFixed(2);
                              return Text(
                                '\$$total',
                                style: const TextStyle(
                                    fontSize: paragraph,
                                    color: primaryColourBlack),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
