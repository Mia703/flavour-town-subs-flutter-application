import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                      changeAccountInfo(supabase, context, widget.column,
                          _accountInputControllerUsername.text);
                    } else {
                      changeAccountInfo(supabase, context, widget.column,
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
