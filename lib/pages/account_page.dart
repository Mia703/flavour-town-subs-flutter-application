import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController _accountUsernameChange;
  late TextEditingController _accountPasswordChange;

  @override
  void initState() {
    _accountUsernameChange = TextEditingController();
    _accountPasswordChange = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _accountUsernameChange.dispose();
    _accountPasswordChange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: addPadding('default', 16.00),
            child: Column(
              children: [
                const Text('Welcome, First LastName'),
                Container(
                  child: Column(
                    children: [
                      const Text('Change Username'),
                      TextField(
                        controller: _accountUsernameChange,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      FilledButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColourBlue),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: paragraph,
                              fontStyle: italic,
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      const Text('Change password'),
                      TextField(
                        controller: _accountPasswordChange,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      FilledButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primaryColourBlue),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: paragraph,
                              fontStyle: italic,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
