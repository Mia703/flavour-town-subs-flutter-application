import 'dart:io';
import 'package:flavour_town_subs_flutter_application/components/alertDialoge.dart';
import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/pages/account_settings_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/history_page.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
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
  String imagePath = currentUser.getAvatarImage();

  final supabase = Supabase.instance.client;

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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // ================= ACCOUNT USER AVATAR CONTAINER =================
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColourLightGrey,
                        radius: 55.0,
                        backgroundImage:
                            imagePath != '' ? FileImage(File(imagePath)) : null,
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
                              // save the user's image
                              bool success = await saveUserAvatar(
                                  supabase, currentUser, pickedImage.path);

                              // if successful, update the avatar display
                              if (success) {
                                setState(() {
                                  imagePath = currentUser.getAvatarImage();
                                });
                              } else {
                                // else display Alert message
                                if (context.mounted) {
                                  displayAlertDialog(
                                      context,
                                      'Avatar Not Saved',
                                      'Sorry, it seems like your image was not saved. Please try again.');
                                }
                              }
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
                                      builder: (context) =>
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
            Align(
              alignment: Alignment.bottomRight,
              child: Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ================= DELETE ACCOUNT BUTTON
                      Container(
                        margin: addMargin('default', 3.00),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Account'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            'Hi, you\'re about to delete your account. This includes all previous and current orders. If that\'s okay, press the button below.'),
                                        addSpacer('height', 10.00),
                                        FilledButton(
                                          onPressed: () async {
                                            // if successfully deleted user, navigate back to main page
                                            if (await deleteUser(
                                                supabase,
                                                context,
                                                currentUser,
                                                currentOrder)) {
                                              if (context.mounted) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyApp()));
                                              }
                                            } else {
                                              if (context.mounted) {
                                                displayAlertDialog(
                                                    context,
                                                    'Unable to Delete Account',
                                                    'Sorry, it seem we were unable to delete your account. Please try again.');
                                              }
                                            }
                                          },
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    primaryColourRed),
                                          ),
                                          child: const Text(
                                            'Delete Account',
                                            style: TextStyle(
                                              fontSize: paragraph,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Delete Account',
                                style: TextStyle(
                                  fontSize: paragraph - 3,
                                  color: primaryColourBlack,
                                ),
                              ),
                              addSpacer('width', 5.00),
                              const Icon(
                                Icons.delete,
                                size: paragraph,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ================= SIGN OUT BUTTON
                      Container(
                        margin: addMargin('default', 3.00),
                        child: MaterialButton(
                          onPressed: () {
                            signOutUser(context, currentUser, currentOrder);
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
