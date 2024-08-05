import 'package:flavour_town_subs_flutter_application/components/history_item.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _historyList;

  final supabase = Supabase.instance.client;

  // returns a list of completed orders (order date and order total)
  Future<List<Map<String, dynamic>>> _getHistoryDates() async {
    try {
      final response = await supabase
          .from('orders')
          .select('order_id, order_date, order_total')
          .eq('order_status', 'completed')
          .eq('user_id', currentUser.getUUID());

      List<Map<String, dynamic>> historyList = [];
      if (response.isEmpty) {
        print('there are no completed orders for this user');
        return historyList; // returns an empty list
      } else {
        print('there is one or more completed orders for this user');

        for (var i = 0; i < response.length; i++) {
          String id = response[i]['order_id'];
          String date = response[i]['order_date'];
          double total = response[i]['order_total'];

          // saves the order_total and order_status in an object
          Map<String, dynamic> historyItem = {
            'order_id': id,
            'order_date': date,
            'order_total': total,
          };

          // save the object
          historyList.add(historyItem);
        }

        return historyList;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    _historyList = _getHistoryDates();
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
        child: FutureBuilder(
          future: _historyList,
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
              final List<Map<String, dynamic>> historyList = snapshot.data!;
              return ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final history = historyList[index];
                  return SingleChildScrollView(
                    // ================= HISTORY ITEM CONTAINER =================
                    child: Column(
                      children: [
                        Container(
                          margin: addMargin('tb', 16.00),
                          padding:
                              addPadding('lr', 16.00) + addPadding('tb', 5.00),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: primaryColourBlack),
                              bottom: BorderSide(
                                color: primaryColourBlack,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ================= ORDER DATE
                              Text(
                                history['order_date'],
                                style: const TextStyle(
                                  fontSize: headerThree,
                                  fontWeight: bold,
                                ),
                              ),
                              // ================= ORDER HISTORY ITEMS
                              HistoryItem(orderId: history['order_id']),
                              // ================= ORDER TOTAL CONTAINER
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: paragraph,
                                    ),
                                  ),
                                  // ================= ORDER TOTAL
                                  Text(
                                    '\$${history['order_total']}',
                                    style: const TextStyle(fontSize: paragraph),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
