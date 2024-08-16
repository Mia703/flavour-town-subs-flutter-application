import 'package:flavour_town_subs_flutter_application/components/history_item.dart';
import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
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

  @override
  void initState() {
    _historyList = getHistory(supabase, currentUser);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================ DISPLAYS ORDER HISTORY
            Expanded(
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
                      child: Text('No previous orders!'),
                    );
                  } else {
                    final List<Map<String, dynamic>> historyList =
                        snapshot.data!;
                    return ListView.builder(
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        final history = historyList[index];
                        return SingleChildScrollView(
                          // ================= HISTORY ITEM CONTAINER =================
                          child: Column(
                            children: [
                              Container(
                                margin: addMargin('bottom', 16.00),
                                padding: addPadding('lr', 16.00) +
                                    addPadding('tb', 5.00),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: primaryColourBlack),
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
                                          color: primaryColourBlue),
                                    ),
                                    addSpacer('height', 10.00),
                                    // ================= ORDER HISTORY ITEMS
                                    HistoryItem(orderId: history['order_id']),
                                    addSpacer('height', 10.00),
                                    // ================= ORDER TOTAL CONTAINER
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total',
                                          style: TextStyle(
                                            fontSize: paragraph,
                                            fontWeight: bold,
                                          ),
                                        ),
                                        // ================= ORDER TOTAL
                                        Text(
                                          '\$${history['order_total']}',
                                          style: const TextStyle(
                                              fontSize: paragraph,
                                              fontWeight: bold),
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
            // ================ DELETE ORDER HISTORY
            Container(
              margin: addMargin('default', 10.00),
              alignment: Alignment.topRight,
              child: FilledButton(
                onPressed: () async {
                  await deleteOrderHistory(supabase, context, currentUser);
                  setState(() {
                    // update order history page
                    _historyList = getHistory(supabase, currentUser);
                  });
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(primaryColourYellow)),
                child: const Text(
                  'Delete Order History?',
                  style: TextStyle(
                    fontSize: paragraph,
                    color: primaryColourBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
