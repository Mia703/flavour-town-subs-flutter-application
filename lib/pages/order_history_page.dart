import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColourWhite,
        title: const Text(
          'Order History',
          style: TextStyle(
            fontSize: headerThree,
            fontWeight: bold,
            fontStyle: italic,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
