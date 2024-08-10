import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

void displayAlertDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: paragraph, fontWeight: bold),
          ),
          content: Text(
            content,
            style: const TextStyle(fontSize: paragraph),
          ),
        );
      });
}
