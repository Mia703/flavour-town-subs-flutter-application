import 'dart:developer';

import 'package:flavour_town_subs_flutter_application/components/alertDialoge.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
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
