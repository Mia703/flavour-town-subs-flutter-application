import 'package:flavour_town_subs_flutter_application/components/account_input.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  late TextEditingController _accountSettingsUsername;
  late TextEditingController _accountSettingsPassword;

  @override
  void initState() {
    _accountSettingsUsername = TextEditingController();
    _accountSettingsPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _accountSettingsUsername.dispose();
    _accountSettingsPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColourWhite,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            fontSize: headerThree,
            fontWeight: bold,
            fontStyle: italic,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AccountInput(
                title: 'Change Username',
                inputPlaceholder: currentUser.getUsername(),
                column: 'username',
              ),
              AccountInput(
                title: 'Change Password',
                inputPlaceholder: currentUser.getPassword(),
                column: 'password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
