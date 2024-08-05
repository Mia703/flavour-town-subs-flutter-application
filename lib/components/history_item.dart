import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key, required this.orderId});

  final String orderId;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  late Future<List<Map<String, dynamic>>> _historyItemsList;

  final supabase = Supabase.instance.client;

  // returns the list of items for a given order
  Future<List<Map<String, dynamic>>> _getHistoryItems(String orderId) async {
    try {
      final response = await supabase
          .from('orders')
          .select(
              'order_items(quantity, item_price), products(product_name, product_price)')
          .eq('order_id', orderId);

      List<Map<String, dynamic>> itemsList = [];
      if (response.isEmpty) {
        print('there are no order items for this order');
        return itemsList;
      } else {
        print('there are order items for this order. getting the items');
        for (var i = 0; i < response.length; i++) {
          var orderItemsList = response[i]['order_items'];
          var productsList = response[i]['products'];

          for (var j = 0; j < orderItemsList.length; j++) {
            int quantity = orderItemsList[j]['quantity'];
            double orderPrice = orderItemsList[j]['item_price'];
            String name = productsList[j]['product_name'];
            double productPrice = productsList[j]['product_price'];

            var item = {
              'quantity': quantity,
              'order_price': orderPrice,
              'item_name': name,
              'item_price': productPrice,
            };

            itemsList.add(item);
          }
        }
        print(itemsList);
        return itemsList;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    _historyItemsList = _getHistoryItems(widget.orderId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _historyItemsList,
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
            final List<Map<String, dynamic>> itemsList = snapshot.data!;
            return ListView.builder(
              // prevents it from interfering with the scroll behaviour of the
              // parent widget
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                final item = itemsList[index];
                return Container(
                  margin: addMargin('lr', 16.00) + addMargin('tb', 5.00),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['item_name'],
                      style: const TextStyle(fontSize: paragraph),
                    ),
                    Padding(
                      padding: addPadding('left', 30.00),
                      child: Text(
                          '${item['quantity']} x ${item['item_price']} = ${item['order_price']}'),
                    ),
                  ],
                ));
              },
            );
          }
        });
  }
}
