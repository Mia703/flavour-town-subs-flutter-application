import 'dart:io';
import 'package:flavour_town_subs_flutter_application/pages/account_settings_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/history_page.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController _accountUsernameChange;
  late TextEditingController _accountPasswordChange;
  File? _imageFile;

  final supabase = Supabase.instance.client;

  Future<void> _saveAvatarImage(String uuid, String imagePath) async {
    try {
      final response =
          await supabase.from('avatars').select('*').eq('uuid', uuid);

      if (response.isEmpty) {
        print('the user\'s image does not exist in the table');

        final data = await supabase
            .from('avatars')
            .insert({'avatars': imagePath})
            .eq('uuid', uuid)
            .select();
      } else {
        print('the user\'s image does exist in the table.');

        final data = await supabase
            .from('avatars')
            .update({'avatars': imagePath})
            .eq('uuid', uuid)
            .select();
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

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

  Future<void> _getAvatarImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColourWhite,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // ================= ACCOUNT USER AVATAR CONTAINER =================
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // TODO: make it so that the material button doesn't disappear
                      // TODO; also make the image persistent
                      CircleAvatar(
                        backgroundColor: primaryColourLightGrey,
                        radius: 55.00,
                        backgroundImage:
                            _imageFile != null ? FileImage(_imageFile!) : null,
                      ),
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: MaterialButton(
                          elevation: 5,
                          color: primaryColourWhite,
                          onPressed: () async {
                            final XFile? pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pickedImage != null) {
                              setState(() {
                                print(
                                    'save the selected image to the database');
                                // _saveAvatarImage(
                                //     currentUser.getUUID(), pickedImage.path);

                                print('display the selected image');
                                _imageFile = File(pickedImage.path);
                              });
                            }
                          },
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: primaryColourBlack,
                              width: 2.00,
                            ),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            size: paragraph,
                            color: primaryColourBlack,
                          ),
                        ),
                      ),
                    ],
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
                                          const HistoryPage()));
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
                ],
              ),
            ),
            // ================= SIGN OUT BUTTON
            Align(
              alignment: Alignment.bottomRight,
              child: Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: addMargin('default', 3.00),
                    color: primaryColourLightGrey,
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
                                fontSize: paragraph - 3,
                                color: primaryColourBlack),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
