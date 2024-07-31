import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO: (later) check to see if you can keep just one TextEditingController

class AccountInput extends StatefulWidget {
  const AccountInput({
    super.key,
    required this.title,
    required this.inputPlaceholder,
    required this.column,
  });

  final String title;
  final String inputPlaceholder;
  final String column;

  @override
  State<StatefulWidget> createState() => _AccountInputState();
}

class _AccountInputState extends State<AccountInput> {
  late TextEditingController _accountInputControllerUsername;
  late TextEditingController _accountInputControllerPassword;

  final supabase = Supabase.instance.client;

  Future<void> _changeAccountInfo(
      BuildContext context, String column, String newValue) async {
    try {
      print('insert new data into table: $column and $newValue');

      final response = await supabase
          .from('users')
          .update({
            column: newValue,
          })
          .eq('firstname', currentUser.getFirstName())
          .eq('lastname', currentUser.getLastName())
          .eq('password', currentUser.getPassword())
          .select();

      if (response.isEmpty) {
        print('new data insertion was not successful');
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Sorry!',
                    style: TextStyle(fontSize: paragraph, fontWeight: bold),
                  ),
                  content: Text(
                    'It looks like your $column was not successful. Please try again.',
                    style: const TextStyle(fontSize: paragraph),
                  ),
                );
              });
        }
      } else {
        print('new data insertion was successful');

        print('update global user object');
        if (column == 'username') {
          currentUser.setUsername(newValue);
        } else {
          currentUser.setPassword(newValue);
        }

        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                    'Your $column has successfully changed.',
                    style: const TextStyle(fontSize: paragraph),
                  ),
                );
              });
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    _accountInputControllerUsername = TextEditingController();
    _accountInputControllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _accountInputControllerUsername.dispose();
    _accountInputControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: addMargin('tb', 16.00),
      padding: addPadding('lr', 16.00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: headerThree,
            ),
          ),
          addSpacer('height', 10.00),
          Center(
            child: Column(
              children: [
                TextField(
                  controller: widget.column == 'username'
                      ? _accountInputControllerUsername
                      : _accountInputControllerPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.inputPlaceholder,
                    filled: true,
                    fillColor: primaryColourLightGrey,
                    labelStyle: const TextStyle(fontSize: paragraph),
                  ),
                ),
                addSpacer('height', 5.00),
                FilledButton(
                  onPressed: () {
                    if (widget.column == 'username') {
                      _changeAccountInfo(context, widget.column,
                          _accountInputControllerUsername.text);
                    } else {
                      _changeAccountInfo(context, widget.column,
                          _accountInputControllerPassword.text);
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryColourBlue),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: paragraph,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
