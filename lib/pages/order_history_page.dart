import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/order_item.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<Map<String, List<OrderItem>>> _orderHistoryList;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _orderHistoryList = _getCompletedOrders();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // returns a list of order items for the specified order_id
  Future<List<OrderItem>> _getOrderItems(String orderId) async {
    print('_getOrderItems, getting items for current order');

    // create list which sill store order item objects
    List<OrderItem> orderItemsList = [];

    // fetch the items
    final items = await supabase
        .from('order_items')
        .select('*')
        .eq('order_id', orderId)
        .order('product_id', ascending: true);

    if (items.isEmpty) {
      print('_getOrderItems, no order items for orderId: $orderId');
      return orderItemsList;
    } else {
      for (var i = 0; i < items.length; i++) {
        // create order item object and update its information
        OrderItem item = OrderItem();
        item.setOrderId(items[i]['order_id']);
        item.setProductId(items[i]['product_id']);
        item.setQuantity(items[i]['quantity']);
        item.setItemPrice(items[i]['item_price']);

        // add item to list
        orderItemsList.add(item);
      }
      return orderItemsList;
    }
  }

  Future<Map<String, List<OrderItem>>> _getCompletedOrders() async {
    // create a temp order history list that will store <String orderId, List<OrderItem>
    Map<String, List<OrderItem>> historyList = {};

    try {
      final response = await supabase
          .from('orders')
          .select('order_id')
          .eq('user_id', currentUser.getUUID())
          .eq('order_status', 'completed');

      if (response.isEmpty) {
        print(
            '_getCompletedOrders, there are no completed orders for this user');
        return historyList;
      } else {
        print('_getCompletedOrders, there are completed orders for this user');

        // for each orderId fetch the list of associated items
        for (var i = 0; i < response.length; i++) {
          // get the current order_id
          var currentOrderId = response[i]['order_id'];
          // get the order_id's associated order items
          // historyList = map, currentOrderId = String, List<OrderItem> = _getOrderItems()
          historyList = {
            currentOrderId: await _getOrderItems(currentOrderId),
          };
        }

        return historyList;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

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
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Text('data'),
        ),
      ),
    );
  }
}
