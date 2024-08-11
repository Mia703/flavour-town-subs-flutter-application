import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartTotal = 0.00;
  late Future<List<Map<String, dynamic>>> _cartItemsList;

  final supabase = Supabase.instance.client;

  // returns the list of items in the cart, only returns the first instance
  Future<List<Map<String, dynamic>>> _getCartItems() async {
    try {
      final response = await supabase
          .from('orders')
          .select(
              'order_id, order_items(quantity, item_price), products(product_name, product_desc, product_price)')
          .eq('user_id', currentUser.getUUID())
          .eq('order_status', 'in-progress');

      List<Map<String, dynamic>> cartItemsList = [];
      if (response.isEmpty) {
        print('user\'s cart is empty');
        return cartItemsList;
      } else {
        print('user\'s cart is not empty');

        final data = response[0];
        String orderId = data['order_id'];
        List<dynamic> orderItemsList = data['order_items'];
        List<dynamic> productsList = data['products'];

        for (var i = 0; i < orderItemsList.length; i++) {
          int quantity = orderItemsList[i]['quantity'];
          double itemPrice = orderItemsList[i]['item_price'];
          String productName = productsList[i]['product_name'];
          String productDesc = productsList[i]['product_desc'];
          double productPrice = productsList[i]['product_price'];

          Map<String, dynamic> cartItem = {
            'quantity': quantity,
            'item_price': itemPrice,
            'product_name': productName,
            'product_desc': productDesc,
            'product_price': productPrice,
          };
          cartItemsList.add(cartItem);
        }
        cartTotal = await _getCartTotal(orderId);
        return cartItemsList;
      }
    } catch (e) {
      throw Exception('Error: e');
    }
  }

  // returns the current order's total
  Future<double> _getCartTotal(String orderId) async {
    final response = await supabase
        .from('orders')
        .select('order_total')
        .eq('order_status', 'in-progress')
        .eq('order_id', orderId)
        .eq('user_id', currentUser.getUUID());

    if (response.isEmpty) {
      print('_getCartTotal: there is no current order, order total is empty');
      return 0.00;
    } else {
      print('_getCartTotal, there is a cart total');
      return response[0]['order_total'];
    }
  }

  // conducts the check out process
  // the in-progress order is marked as complete
  Future<void> _checkOutCart(BuildContext context) async {
    try {
      final response = await supabase
          .from('orders')
          .update({'order_status': 'completed'})
          .eq('user_id', currentUser.getUUID())
          .select();

      if (response.isEmpty) {
        print('_checkOutCart, check out was not successful');
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text(
                    'Check Out Not Successful',
                    style: TextStyle(
                      fontSize: paragraph,
                      fontWeight: bold,
                    ),
                  ),
                  content: Text(
                    'Sorry, your check out was not successful. Pleas try again.',
                    style: TextStyle(
                      fontSize: paragraph,
                      fontWeight: bold,
                    ),
                  ),
                );
              });
        }
      } else {
        print('_checkOutCart, check out was successful');
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text(
                    'Check Out Successful',
                    style: TextStyle(
                      fontSize: paragraph,
                      fontWeight: bold,
                    ),
                  ),
                  content: Text(
                    'Your checkout was successful. Navigating back to menu page.',
                    style: TextStyle(
                      fontSize: paragraph,
                      fontWeight: bold,
                    ),
                  ),
                );
              });

          // navigate to product's page
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProductPage()));
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    _cartItemsList = _getCartItems();
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
              // ================= ADD TO CART BUTTON =================
              Padding(
                padding: addPadding('tb', 16.00) + addPadding('lr', 10.00),
                child: FilledButton(
                  onPressed: () {
                    _checkOutCart(context);
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
                      Text(
                        '\$$cartTotal',
                        style: const TextStyle(
                            fontSize: paragraph, color: primaryColourBlack),
                      ),
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
