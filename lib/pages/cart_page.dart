import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

// TODO: get order based on order_status

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
              fontSize: headerThree, fontWeight: bold, fontStyle: italic),
        ),
        backgroundColor: primaryColourWhite,
      ),
    );
  }
}
