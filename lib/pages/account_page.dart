import 'package:flavour_town_subs_flutter_application/pages/account_settings_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/order_history_page.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController _accountUsernameChange;
  late TextEditingController _accountPasswordChange;

  final supabase = Supabase.instance.client;

  // Future<void> _getUsersName() async {
  //   try {
  //     print('get the user\'s first and last name');

  //     final response = await supabase
  //         .from('users')
  //         .select('firstname, lastname')
  //         .eq('username', username);
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

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
      appBar: AppBar(
        backgroundColor: primaryColourWhite,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ================= ACCOUNT USER AVATAR CONTAINER =================
            Center(
              child: MaterialButton(
                onPressed: () {
                  // TODO: on press open gallery to add image
                },
                shape: const CircleBorder(
                    side: BorderSide(color: primaryColourRed, width: 2.00)),
                child: const CircleAvatar(
                  backgroundColor: primaryColourLightGrey,
                  radius: 50.00,
                  child: Icon(Icons.add_a_photo),
                ),
              ),
            ),
            addSpacer('height', 16.00),
            // ================= ACCOUNT USER FIRST & LAST NAME =================
            Text(
              '${currentUser.getFirstName()} ${currentUser.getLastName()}',
              style: const TextStyle(
                fontSize: headerTwo,
                fontWeight: bold,
                color: primaryColourBlack,
              ),
            ),
            // ================= ACCOUNT BUTTON NAVIGATION CONTAINER =================
            Container(
              margin: addMargin('tb', 16.00),
              child: Column(
                children: [
                  // ================= ACCOUNT SETTINGS BTN
                  Container(
                    margin: addMargin('tb', 5.00),
                    child: MaterialButton(
                      padding: addPadding('default', 16.00),
                      onPressed: () {
                        print('navigating to account settings page');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountSettingsPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.settings),
                              addSpacer('width', 5.00),
                              const Text(
                                'Account Settings',
                                style: TextStyle(
                                  fontSize: paragraph,
                                  color: primaryColourBlack,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: headerThree,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ================= ORDER HISTORY BTN
                  Container(
                    margin: addMargin('tb', 5.00),
                    child: MaterialButton(
                      padding: addPadding('default', 16.00),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (countext) =>
                                    const OrderHistoryPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.history),
                              addSpacer('width', 5.00),
                              const Text(
                                'Order History',
                                style: TextStyle(
                                  fontSize: paragraph,
                                  color: primaryColourBlack,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: headerThree,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ================= SIGN OUT BUTTON
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  onPressed: () {
                    print('sign out. clearing global user object');
                    currentUser.clearData();

                    print('navigating back to login page');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign Out',
                        style: TextStyle(
                            fontSize: paragraph - 3, color: primaryColourBlack),
                      ),
                      addSpacer('width', 5.00),
                      const Icon(
                        Icons.logout,
                        size: paragraph,
                      ),
                    ],
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
