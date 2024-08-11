import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flavour_town_subs_flutter_application/components/alertDialoge.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/models/currentUser.dart';
import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final DateTime today = DateTime.now();

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
        currentUser.setAvatarImage('image_path');

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
      await createOrder(supabase, user);
      return false;
    }
  } catch (e) {
    log('getInProgressOrder Error: $e');
    throw Exception('getInProgressOrder Error: $e');
  }
}

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
    await getInProgressOrder(supabase, user);
    // updates or inserts order item
    await getOrderItem(
        supabase, user, currentOrder.getOrderId(), productId, productPrice);
  } catch (e) {
    log('addToCart Error: $e');
    throw Exception('addToCart Error: $e');
  }
}

Future<int> getCartItems(SupabaseClient supabase, String orderId) async {
  try {
    final response = await supabase
        .from('order_items')
        .select('quantity')
        .eq('order_id', orderId);

    if (response.isNotEmpty) {
      log('getCartItems: order has order items, returning cart items total');
      int totalQuantity = 0;
      for (int i = 0; i < response.length; i++) {
        totalQuantity += response[i]['quantity'] as int;
      }
      return totalQuantity;
    } else {
      log('getCarItems: order has no order items, returning 0 for cart items total');
      return 0;
    }
  } catch (e) {
    log('getCartItems Error: $e');
    throw Exception('getCart Items Error: $e');
  }
}
