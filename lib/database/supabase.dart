import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flavour_town_subs_flutter_application/components/alertDialoge.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/models/currentUser.dart';
import 'package:flavour_town_subs_flutter_application/models/order.dart';
import 'package:flavour_town_subs_flutter_application/pages/cart_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final DateTime today = DateTime.now();

// ================= AUTH FUNCTIONS =================

Future<void> loginUser(SupabaseClient supabase, BuildContext context,
    String username, String password) async {
  try {
    final response = await supabase
        .from('users')
        .select('*')
        .eq('username', username)
        .eq('password', password);

    if (response.isNotEmpty) {
      if (response.length == 1) {
        log('loginUser: only one user exists in the table. updating the global user object to the current user.');

        final data = response[0];
        currentUser.setUUID(data['uuid']);
        currentUser.setFirstName(data['firstname']);
        currentUser.setLastName(data['lastname']);
        currentUser.setUsername(data['username']);
        currentUser.setPassword(data['password']);
        currentUser.setAvatarImage(data['image_path'] ?? '');

        await getInProgressOrder(supabase, currentUser);

        log('loginUser: navigating to products page');
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProductPage()));
        }
      } else {
        log('loginUser: there is more than one user returned. duplicate users?');
      }
    } else {
      log('loginUser: the response is empty. the user does not exist in the table. tell user to sign up.');
      if (context.mounted) {
        displayAlertDialog(context, 'Incorrect Username or Password',
            'The username or password you\'ve entered is incorrect. Please try again.');
      }
    }
  } catch (e) {
    log('loginUser Error: $e');
    throw Exception('loginUser Error: $e');
  }
}

Future<void> signUpUser(SupabaseClient supabase, BuildContext context,
    String firstName, String lastName, String username, String password) async {
  try {
    log('signUpUser: check if the user already exists in the table');

    final response =
        await supabase.from('users').select('uuid').eq('username', username);

    if (response.isNotEmpty) {
      log('signUpUser: the user exists in the table. direct to login page');
      if (context.mounted) {
        displayAlertDialog(context, 'Username Already Exists',
            'The username you\'ve entered already exists. Please consider logging in or entering a new username.');
      }
    } else {
      log('signUpUser: the user does not exist in the table. insert user');

      String userId = uuid.v1();
      final data = await supabase.from('users').insert({
        'uuid': userId,
        'firstname': firstName,
        'lastname': lastName,
        'username': username,
        'password': password,
      }).select();

      if (data.isNotEmpty) {
        log('signUpUser: data insertion was successful. updating global user object');

        currentUser.setUUID(userId);
        currentUser.setFirstName(firstName);
        currentUser.setLastName(lastName);
        currentUser.setUsername(username);
        currentUser.setPassword(password);
        currentUser.setAvatarImage('');

        log('signUpUser: navigating to products page');
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProductPage()));
        }
      } else {
        log('signUpUser: data insertion was not successful.');
        if (context.mounted) {
          displayAlertDialog(context, 'Sorry!',
              'It seems your sign up was unsuccessful. Please try again.');
        }
      }
    }
  } catch (e) {
    log('signUpUser Error: $e');
    throw Exception('signUpUser Error: $e');
  }
}

void signOutUser(BuildContext context, CurrentUser user, Order order) {
  log('signing out user; cleared order and user information');
  order.clearOrder();
  user.clearData();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

Future<bool> deleteUser(SupabaseClient supabase, BuildContext context,
    CurrentUser user, Order order) async {
  try {
    log('deleteUser: delete user\'s orders, even if user has no orders');
    await supabase
        .from('orders')
        .delete()
        .eq('user_id', user.getUUID())
        .select();

    final userData = await supabase
        .from('users')
        .delete()
        .eq('uuid', user.getUUID())
        .select();

    if (userData.isNotEmpty) {
      log('deleteUser: successfully deleted user');
      order.clearOrder();
      user.clearData();
      return true;
    } else {
      log('deleteUser: could not delete user');
      return false;
    }
  } catch (e) {
    log('deleteUser Error: $e');
    throw Exception('deleteUser Error: $e');
  }
}

// ================= PRODUCT PAGE =================

// returns the list of products by type, ordered by product name
Future<List<Map<String, dynamic>>> getProductsByType(
    SupabaseClient supabase, String type) async {
  try {
    final response = await supabase
        .from('products')
        .select('*')
        .eq('product_type', type)
        .order('product_name', ascending: true);

    if (response.isNotEmpty) {
      return response;
    } else {
      log('getProductsByType: unable to get products. response is empty');
      throw Exception('getProductsByType Error: Response is empty');
    }
  } catch (e) {
    log('getProductsByType Error: $e');
    throw Exception('getProductsByType Error: $e');
  }
}

// returns true if the user has an in-progress order
Future<bool> getInProgressOrder(
    SupabaseClient supabase, CurrentUser user) async {
  try {
    final response = await supabase
        .from('orders')
        .select('*')
        .eq('user_id', user.getUUID())
        .eq('order_status', 'in-progress');

    if (response.isNotEmpty) {
      log('getInProgressOrder: the user has an in-progress order. updating global order object');
      final data = response[0];
      currentOrder.setOrderID(data['order_id']);
      currentOrder.setUserID(data['user_id']);
      currentOrder.setOrderDate(data['order_date']);
      currentOrder.setOrderTime(data['order_time']);
      currentOrder.setOrderStatus(data['order_status']);
      currentOrder.setOrderTotal(data['order_total']);
      return true;
    } else {
      log('getInProgressOrder: the user does not have an in-progress order. inserting order');
      return false;
    }
  } catch (e) {
    log('getInProgressOrder Error: $e');
    throw Exception('getInProgressOrder Error: $e');
  }
}

// creates a new order, updates the Order object
Future<void> createOrder(SupabaseClient supabase, CurrentUser user) async {
  try {
    String orderId = uuid.v1();

    final response = await supabase.from('orders').insert({
      'order_id': orderId,
      'user_id': user.getUUID(),
      'order_date': formatDate(today, [yyyy, '-', mm, '-', dd]),
      'order_status': 'in-progress',
      'order_total': 0.00,
    }).select();

    if (response.isNotEmpty) {
      log('createOrder: order insertion successful');

      final data = response[0];
      currentOrder.setOrderID(data['order_id']);
      currentOrder.setUserID(data['user_id']);
      currentOrder.setOrderDate(data['order_date']);
      currentOrder.setOrderTime(data['order_time']);
      currentOrder.setOrderStatus(data['order_status']);
      currentOrder.setOrderTotal(data['order_total']);
    } else {
      log('createOrder: order insertion unsuccessful');
      throw Exception('createOrder Error: order insertion unsuccessful');
    }
  } catch (e) {
    log('createOrder Error: $e');
    throw Exception('createOrder Error: $e');
  }
}

// updates the quantity of an order-item or inserts the item into the order
// updates the order total afterwards
Future<void> getOrderItem(SupabaseClient supabase, CurrentUser user,
    String orderId, int productId, double productPrice) async {
  try {
    final response = await supabase
        .from('order_items')
        .select('*')
        .eq('order_id', orderId)
        .eq('product_id', productId);

    if (response.isNotEmpty) {
      log('getOrderItems: selected item is present in order. update quantity');
      await incrementQuantity(supabase, orderId, productId);
    } else {
      log('getOrderItems: selected item is not present in order. insert item');
      await insertOrderItem(supabase, orderId, productId, 1, productPrice);
    }
    await updateOrderTotal(supabase, user, orderId);
  } catch (e) {
    log('getOrderItem Error: $e');
    throw Exception('getOrderItem Error: $e');
  }
}

// inserts an order-item into the table
Future<void> insertOrderItem(SupabaseClient supabase, String orderId,
    int productId, int quantity, double itemPrice) async {
  try {
    final response = await supabase.from('order_items').insert({
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'item_price': itemPrice,
    }).select();

    if (response.isNotEmpty) {
      log('insertOrderItem: item insertion was successful');
    } else {
      log('insertOrderItem: item insertion was unsuccessful');
    }
  } catch (e) {
    log('insertOrderItem Error: $e');
    throw Exception('insertOrderItem Error: $e');
  }
}

// increases an order-item's quantity
Future<void> incrementQuantity(
    SupabaseClient supabase, String orderId, int productId) async {
  try {
    final response = await supabase
        .from('order_items')
        .select('quantity, products(product_price)')
        .eq('order_id', orderId)
        .eq('product_id', productId);

    if (response.isNotEmpty) {
      final data = response[0];
      int quantity = data['quantity'];
      double productPrice = data['products']['product_price'];
      quantity += 1;
      double price = quantity * productPrice;

      final item = await supabase
          .from('order_items')
          .update({
            'quantity': quantity,
            'item_price': price,
          })
          .eq('order_id', orderId)
          .eq('product_id', productId)
          .select();

      if (item.isNotEmpty) {
        log('incrementQuantity: incrementing quantity was successful');
      } else {
        log('incrementQuantity: incrementing quantity was not successful');
        throw Exception(
            'incrementQuantity Error: unable to increment quantity');
      }
    } else {
      log('incrementQuantity: the selected order item is not present in the order');
    }
  } catch (e) {
    log('incrementQuantity Error: $e');
    throw Exception('incrementQuantity Error: $e');
  }
}

// updates an order's total
Future<void> updateOrderTotal(
    SupabaseClient supabase, CurrentUser user, String orderId) async {
  try {
    final response = await supabase
        .from('order_items')
        .select('item_price')
        .eq('order_id', orderId);

    if (response.isNotEmpty) {
      log('updateOrderTotal: the current order has order items. calculating total');

      double orderTotal = 0;
      for (int i = 0; i < response.length; i++) {
        orderTotal += response[i]['item_price'];
      }

      final data = await supabase
          .from('orders')
          .update({
            'order_total': orderTotal,
          })
          .eq('order_id', orderId)
          .eq('user_id', user.getUUID())
          .select();

      if (data.isNotEmpty) {
        log('updateOrderTotal: order total update was successful');
      } else {
        log('updateOrderTotal: order total update was not successful');
      }
    } else {
      log('updateOrderTotal; the current order has no order items');
    }
  } catch (e) {
    log('updateOrderTotal Error: $e');
    throw Exception('updateOrderTotal Error: $e');
  }
}

Future<void> addToCart(SupabaseClient supabase, BuildContext context,
    CurrentUser user, int productId, double productPrice) async {
  try {
    // updates or inserts order
    if (!await getInProgressOrder(supabase, user)) {
      await createOrder(supabase, user);
    }
    // updates or inserts order item
    await getOrderItem(
        supabase, user, currentOrder.getOrderId(), productId, productPrice);
  } catch (e) {
    log('addToCart Error: $e');
    throw Exception('addToCart Error: $e');
  }
}

// returns the number of items in an order
Future<int> countCartItems(SupabaseClient supabase, String orderId) async {
  try {
    if (orderId != '') {
      final response = await supabase
          .from('order_items')
          .select('quantity')
          .eq('order_id', orderId);

      if (response.isNotEmpty) {
        // log('countCartItems: order has order items, returning cart items total');
        int totalQuantity = 0;
        for (int i = 0; i < response.length; i++) {
          totalQuantity += response[i]['quantity'] as int;
        }
        return totalQuantity;
      } else {
        log('getCarItems: order has no order items, returning 0 for cart items total');
        return 0;
      }
    } else {
      // log('countCartItems: orderId is empty. Meaning cart is empty after checkout or no create order triggered yet.');
      // log('countCartItems: returning 0');
      return 0;
    }
  } catch (e) {
    log('countCartItems Error: $e');
    throw Exception('getCart Items Error: $e');
  }
}

// ================= CART PAGE =================

// returns the list of items in the cart
Future<List<Map<String, dynamic>>> getCartItems(
    SupabaseClient supabase, CurrentUser user, String orderId) async {
  try {
    final response = await supabase
        .from('orders')
        .select(
            'order_id, order_items(product_id, quantity, item_price), products(product_name, product_desc, product_price)')
        .eq('user_id', user.getUUID())
        .eq('order_status', 'in-progress');

    List<Map<String, dynamic>> cartItemsList = [];
    if (response.isNotEmpty) {
      log('getCartItems: user\'s cart is not empty. fetching cart items');

      final data = response[0];
      List<dynamic> orderItemsList = data['order_items'];
      List<dynamic> productsList = data['products'];

      for (var i = 0; i < orderItemsList.length; i++) {
        int productId = orderItemsList[i]['product_id'];
        int quantity = orderItemsList[i]['quantity'];
        double itemPrice = orderItemsList[i]['item_price'];
        String productName = productsList[i]['product_name'];
        String productDesc = productsList[i]['product_desc'];
        double productPrice = productsList[i]['product_price'];

        Map<String, dynamic> cartItem = {
          'order_id': response[0]['order_id'],
          'product_id': productId,
          'quantity': quantity,
          'item_price': itemPrice,
          'product_name': productName,
          'product_desc': productDesc,
          'product_price': productPrice,
        };

        cartItemsList.add(cartItem);
      }
      return cartItemsList;
    } else {
      log('getCartItems: the user\'s cart is empty');
      return cartItemsList;
    }
  } catch (e) {
    log('getCartItems Error: $e');
    throw Exception('getCartItems Error: $e');
  }
}

Future<void> deleteCartItem(
    SupabaseClient supabase,
    BuildContext context,
    String orderId,
    int productId,
    int quantity,
    double productPrice,
    double itemPrice) async {
  try {
    if (quantity == 1) {
      log('deleteCartItem: quantity equals 1. deleting row');
      final response = await supabase
          .from('order_items')
          .delete()
          .eq('order_id', orderId)
          .eq('product_id', productId)
          .select();

      if (response.isNotEmpty) {
        log('deleteCartItem: successfully deleted cart item. refreshing page');
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        }
      } else {
        log('deleteCartItem: unable to delete cart item');
      }
    } else {
      log('deleteCartItem: quantity is greater than 1, updating row');
      final response = await supabase
          .from('order_items')
          .update({
            'quantity': quantity - 1,
            'item_price': itemPrice - productPrice,
          })
          .eq('order_id', orderId)
          .eq('product_id', productId)
          .select();

      if (response.isNotEmpty) {
        log('deleteCartItem: decreased cart item quantity. refreshing page');
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        }
      } else {
        log('deleteCartItem: unable to decrease cart item quantity');
      }
    }
  } catch (e) {
    log('deleteCartItem Error: $e');
  }
}

Future<double> getCartTotal(
    SupabaseClient supabase, CurrentUser user, String orderId) async {
  try {
    final response = await supabase
        .from('orders')
        .select('order_total')
        .eq('order_status', 'in-progress')
        .eq('user_id', user.getUUID())
        .eq('order_id', orderId);

    if (response.isNotEmpty) {
      // log('getCartTotal: returning the total cart price');
      return response[0]['order_total'];
    } else {
      log('getCartTotal: there is no current order or cart is empty');
      return 0;
    }
  } catch (e) {
    log('getCartTotal Error: $e');
    throw Exception('getCartTotal Error: $e');
  }
}

Future<bool> checkout(SupabaseClient supabase, BuildContext context,
    CurrentUser user, Order order) async {
  try {
    final response = await supabase
        .from('orders')
        .update({
          'order_status': 'completed',
        })
        .eq('user_id', user.getUUID())
        .eq('order_id', order.getOrderId())
        .eq('order_status', 'in-progress')
        .select();
    if (response.isNotEmpty) {
      log('checkout: check out successful');
      order.clearOrder();
      return true;
    } else {
      log('checkout: checkout unsuccessful');
      return false;
    }
  } catch (e) {
    log('checkout Error: $e');
    throw Exception('checkout Error: $e');
  }
}

// ================= ORDER HISTORY PAGE =================

// returns a list with the user's previous orders
Future<List<Map<String, dynamic>>> getHistory(
    SupabaseClient supabase, CurrentUser user) async {
  try {
    final response = await supabase
        .from('orders')
        .select('order_id, order_date, order_total')
        .eq('order_status', 'completed')
        .eq('user_id', user.getUUID())
        .order('order_date', ascending: true)
        .order('order_time', ascending: false);

    List<Map<String, dynamic>> historyList = [];
    if (response.isNotEmpty) {
      log('getHistory: there is one or more completed orders for this user');

      for (var i = 0; i < response.length; i++) {
        String orderId = response[i]['order_id'];
        String date = response[i]['order_date'];
        double orderTotal = response[i]['order_total'];

        // saves the order information in an object
        Map<String, dynamic> historyItem = {
          'order_id': orderId,
          'order_date': date,
          'order_total': orderTotal,
        };

        // save the object
        historyList.add(historyItem);
      }

      return historyList;
    } else {
      log('getHistory: there are no completed orders for this user');
      return historyList;
    }
  } catch (e) {
    log('getHistory Error: $e');
    throw Exception('getHistory Error: $e');
  }
}

// delete all completed orders
Future<void> deleteOrderHistory(
    SupabaseClient supabase, BuildContext context, CurrentUser user) async {
  try {
    final response = await supabase
        .from('orders')
        .delete()
        .eq('user_id', user.getUUID())
        .eq('order_status', 'completed')
        .select();
    if (response.isNotEmpty) {
      log('deleteOrderHistory: successfully deleted order history');
      await Future.delayed(const Duration(seconds: 2));
      if (context.mounted) {
        displayAlertDialog(context, 'Order History Deleted',
            'Your order history was successfully deleted.');
      }
    } else {
      log('deleteOrderHistory: order history unsuccessfully deleted');
      await Future.delayed(const Duration(seconds: 2));
      if (context.mounted) {
        displayAlertDialog(context, 'Order History Not Deleted',
            'Sorry, your order history was unsuccessfully deleted. Please try again.');
      }
    }
  } catch (e) {
    log('deleteOrderHistory Error: $e');
    throw Exception('deleteOrderHistory Error: $e');
  }
}

// returns the list of order items from a specified order
Future<List<Map<String, dynamic>>> getHistoryItems(
    SupabaseClient supabase, String orderId) async {
  try {
    final response = await supabase
        .from('orders')
        .select(
            'order_items(quantity, item_price), products(product_name, product_price)')
        .eq('order_id', orderId);

    List<Map<String, dynamic>> itemsList = [];
    if (response.isEmpty) {
      log('getHistoryItems: there are no order items for this order');
      return itemsList;
    } else {
      log('getHistoryItems: there are order items for this order. getting the items');
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
            'order_price': orderPrice.toStringAsFixed(2),
            'item_name': name,
            'item_price': productPrice.toStringAsFixed(2),
          };

          itemsList.add(item);
        }
      }
      return itemsList;
    }
  } catch (e) {
    log('getHistoryItems Error: $e');
    throw Exception('getHistoryItems Error: $e');
  }
}

// ================= ACCOUNT PAGE =================

// saves the user's selected image to the table
Future<bool> saveUserAvatar(
    SupabaseClient supabase, CurrentUser user, String imagePath) async {
  try {
    final response = await supabase
        .from('users')
        .update({'image_path': imagePath})
        .eq('uuid', user.getUUID())
        .select();

    if (response.isNotEmpty) {
      log('saveUserAvatar: user\'s avatar was successfully saved');
      user.setAvatarImage(imagePath);
      return true;
    } else {
      log('saveUserAvatar: user\'s avatar was not successfully saved');
      return false;
    }
  } catch (e) {
    log('saveUserAvatar Error: $e');
    throw Exception('saveUserAvatar Error: $e');
  }
}

// changes user's user name or password
Future<void> changeAccountInfo(SupabaseClient supabase, BuildContext context,
    String column, String newValue) async {
  try {
    log('changeAccountInfo: insert new data into table: $column and $newValue');

    final response = await supabase
        .from('users')
        .update({
          column: newValue,
        })
        .eq('firstname', currentUser.getFirstName())
        .eq('lastname', currentUser.getLastName())
        .eq('password', currentUser.getPassword())
        .select();

    if (response.isNotEmpty) {
      log('changeAccountInfo: new data insertion was successful. updating user object');
      if (column == 'username') {
        currentUser.setUsername(newValue);
      } else {
        currentUser.setPassword(newValue);
      }

      if (context.mounted) {
        displayAlertDialog(
            context, 'Changed $column', 'Successfully changed $column');
      }
    } else {
      log('changeAccountInfo: new data insertion was not successful');
      if (context.mounted) {
        displayAlertDialog(context, 'Sorry!',
            'It looks like your $column was not successful. Please try again.');
      }
    }
  } catch (e) {
    log('changeAccountInfo Error: $e');
    throw Exception('changeAccountInfo Error: $e');
  }
}
