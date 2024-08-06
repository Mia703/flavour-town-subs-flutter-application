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
  var cartTotal = 0.00;
  late Future<List<Map<String, dynamic>>> _cartItemsList;

  final supabase = Supabase.instance.client;

  // returns the list of items in the cart, only returns the first instance
  Future<List<Map<String, dynamic>>> _getCartItems() async {
    try {
      final response = await supabase
          .from('orders')
          .select(
              'order_items(quantity, item_price), products(product_name, product_desc, product_price)')
          .eq('user_id', currentUser.getUUID())
          .eq('order_status', 'in-progress');

      List<Map<String, dynamic>> cartItemsList = [];
      if (response.isEmpty) {
        print('user\'s cart is empty');
        return cartItemsList;
      } else {
        print('user\'s cart is not empty');

        final data = response[0];

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
        cartTotal = await _getCartTotal();
        return cartItemsList;
      }
    } catch (e) {
      throw Exception('Error: e');
    }
  }

  // returns the current order's total
  Future<double> _getCartTotal() async {
    final response = await supabase
        .from('orders')
        .select('order_total')
        .eq('order_status', 'in-progress');

    if (response.isEmpty) {
      print('_getCartTotal: there is no current order, order total is empty');
      return 0.00;
    } else {
      print('_getCartTotal, there is a cart total');
      return response[0]['order_total'];
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
                      child: Text('Error: There is no data'),
                    );
                  } else {
                    final List<Map<String, dynamic>> cartItemsList =
                        snapshot.data!;
                    return ListView.builder(
                      itemCount: cartItemsList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartItemsList[index];
                        final double itemPrice =
                            cartItemsList[index]['item_price'];
                        final String itemPriceString =
                            itemPrice.toStringAsFixed(2);
                        // ================= CART ITEM CONTAINER =================
                        return Container(
                          margin: addMargin('tb', 10.00) +
                              addMargin('lr', 16.00),
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
                                style:
                                    const TextStyle(fontSize: paragraph),
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
                  onPressed: () {},
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