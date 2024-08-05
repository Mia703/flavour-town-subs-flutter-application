import 'package:date_format/date_format.dart';
import 'package:flavour_town_subs_flutter_application/order.dart';
import 'package:flavour_town_subs_flutter_application/order_item.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flavour_town_subs_flutter_application/user.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();
final DateTime date = DateTime.now();
final supabase = Supabase.instance.client;
Order currentOrder = Order();

// TODO: update functions to deal with errors. (i.e. display error alert dialog)

// determines if an item is in the cart
// if in cart, return true
Future<bool> _isInCart(Order currentOrder, int itemId) async {
  final response = await supabase
      .from('order_items')
      .select('*')
      .eq('order_id', currentOrder.getOrderId())
      .eq('product_id', itemId);

  if (response.isEmpty) {
    print('NO, the current item is not already in the cart');
    return false;
  } else {
    print('YES, the current item is already in the cart');
    return true;
  }
}

Future<void> _updateOrderTotal(Order currentOrder) async {
  final response = await supabase
      .from('order_items')
      .select('item_price')
      .eq('order_id', currentOrder.getOrderId());

  if (response.isEmpty) {
    print('Error: _updateOrderTotal, could not fetch items in order');
  } else {
    double price = 0.00;
    for (var i = 0; i < response.length; i++) {
      price += response[i]['item_price'];
    }

    print('updating order total...');
    final order = await supabase
        .from('orders')
        .update({
          'order_total': price,
        })
        .eq('order_id', currentOrder.getOrderId())
        .select();

    if (order.isEmpty) {
      print('Error: _updateOrderTotal, could not update order_total');
    } else {
      print('_updateOrderTotal: order total was successfully updated');
    }
  }
}

Future<void> _updateOrderCount(Order currentOrder) async {
  final response = await supabase
      .from('order_items')
      .select('order_id')
      .eq('order_id', currentOrder.getOrderId())
      .count(CountOption.estimated);

  final count = response.count;
  currentOrder.setOrderCount(count);
}

Future<void> _addToCart(CurrentUser user, int productID, String name,
    String description, String price, String image) async {
  try {
    print(
        '_addToCart: check if the user already has an order and is in-progress');

    final response = await supabase
        .from('orders')
        .select('*')
        .eq('user_id', user.uuid)
        .eq('order_status', 'in-progress');

    if (response.isEmpty) {
      print(
          'NO: the current user has no in-progress orders. creating a new order entry');

      var order_id = uuid.v1();
      String todaysDate = formatDate(date, [yyyy, '-', mm, '-', dd]);

      final order_data = await supabase.from('orders').insert({
        'order_id': order_id,
        'user_id': user.getUUID(),
        'order_date': todaysDate,
        'order_status': 'in-progress',
        'order_total': price,
      }).select();

      if (order_data.isEmpty) {
        print('create order: data insertion was not successful');
      } else {
        print(
            'create order: data insertion was successful. inserting item into order_items table');
        final selected_item_data = await supabase.from('order_items').insert({
          'order_id': order_id,
          'product_id': productID,
          'quantity': 1,
          'item_price': price,
        }).select();

        if (selected_item_data.isEmpty) {
          print('create order item: data insertion was not successful');
        } else {
          print('create order item: data insertion was successful');
        }
      }
    } else {
      print('YES: the current user has an in-progress order');

      // get the data from the response
      final data = response[0];

      // update the order object
      currentOrder.setOrderID(data['order_id']);
      currentOrder.setUserID(data['user_id']);
      currentOrder.setOrderDate(data['order_date']);
      currentOrder.setOrderStatus(data['order_status']);
      currentOrder.setOrderTotal(data['order_total']);

      print('_addToCart: is the item is already in the cart?');

      if (await _isInCart(currentOrder, productID)) {
        print('getting selected item from table...');

        final item = await supabase
            .from('order_items')
            .select('*')
            .eq('order_id', currentOrder.getOrderId())
            .eq('product_id', productID);

        if (item.isEmpty) {
          print('Error: _addToCart, item was not fetched');
        } else {
          print('_addToCart, item was fetched');
          final data = item[0];

          OrderItem currentItem = OrderItem();
          currentItem.setOrderId(data['order_id']);
          currentItem.setProductId(data['product_id']);
          currentItem.setQuantity(data['quantity']);
          currentItem.setItemPrice(data['item_price']);

          print('updating item in table...');

          final updated_item = await supabase
              .from('order_items')
              .update({
                'quantity': currentItem.incrementQuantity().toString(),
                'item_price': currentItem
                    .addToItemPrice(double.parse(price))
                    .toStringAsFixed(2),
              })
              .eq('order_id', currentItem.getOrderId())
              .eq('product_id', currentItem.getProductId())
              .select();

          if (updated_item.isEmpty) {
            print('_addToCart: updating selected item was not successful');
          } else {
            print('_addToCart: updating selected item was successful');
          }
        }
      } else {
        print('inserting item into table...');

        final item = await supabase.from('order_items').insert({
          'order_id': currentOrder.getOrderId(),
          'product_id': productID,
          'quantity': 1,
          'item_price': price,
        }).select();

        if (item.isEmpty) {
          print('_addToCart: inserting item into table was not successful');
        } else {
          print('_addToCart: inserting item into table was successful');
        }
      }

      _updateOrderTotal(currentOrder);
      _updateOrderCount(currentOrder);
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

void showProductDetailWidget(BuildContext context, CurrentUser user, int id,
    String name, String description, String price, String image) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 5,
      builder: (context) => Container(
            width: double.infinity,
            padding: addPadding('default', 16.00),
            constraints: BoxConstraints(
              // max height is 80% of the device's height
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              children: [
                // ================= PRODUCT IMAGE
                Image(image: AssetImage(image)),
                // ================= PRODUCT NAME
                Text(
                  name,
                  style: const TextStyle(fontSize: headerTwo),
                  textAlign: TextAlign.center,
                ),
                addSpacer('height', 20.00),
                // ================= PRODUCT DESCRIPTION
                Text(
                  '$description.',
                  style: const TextStyle(
                    fontSize: paragraph,
                  ),
                  textAlign: TextAlign.center,
                ),
                // ================= ADD TO CART BUTTON + PRICE
                Flexible(
                  fit: FlexFit.loose,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FilledButton(
                      onPressed: () async {
                        // adds item to cart and updates badge icon
                        _addToCart(user, id, name, description, price, image);
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(primaryColourBlue),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '\$$price',
                            style: const TextStyle(fontSize: headerThree),
                          ),
                          const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: paragraph),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
}
