import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

// ================== SIGN UP PAGE ==================
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var uuid = const Uuid();

  // retrieves inputs
  final TextEditingController signUpControllerFirstName =
      TextEditingController();
  final TextEditingController signUpControllerLastName =
      TextEditingController();
  final TextEditingController signUpControllerUsername =
      TextEditingController();
  final TextEditingController signUpControllerPassword =
      TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    signUpControllerFirstName.dispose();
    signUpControllerLastName.dispose();
    signUpControllerUsername.dispose();
    signUpControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // ================== BACKGROUND IMAGE ==================
            const Image(
              image: AssetImage(
                  'lib/assets/pexels-ahmed-rabea-2883687-4559174.jpg'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // ================== OVERLAY ==================
            Container(
              width: double.infinity,
              height: double.infinity,
              color: primaryOverlay,
            ),
            // ================== SIGN UP FORM CONTAINER ==================
            Center(
              child: Container(
                margin: primaryMarginAll,
                padding: primaryPaddingAll * 2,
                decoration: const BoxDecoration(
                  borderRadius: primaryBorderRadius,
                  color: primaryColourWhite,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ================== sign up form header
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: headerOne,
                        fontWeight: bold,
                        color: primaryColourBlack,
                      ),
                    ),
                    primarySizedBox,
                    // ================== sign up form sub-header
                    const Text(
                      'Sign up to get started ordering online.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: headerTwo - 8,
                        color: primaryColourBlack,
                      ),
                    ),
                    const SizedBox(height: primarySpacer * 2),
                    // ================== sign up form - first name input
                    TextField(
                      controller: signUpControllerFirstName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        filled: true,
                        fillColor: primaryColourWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - last name input
                    TextField(
                      controller: signUpControllerLastName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        filled: true,
                        fillColor: primaryColourWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - username input
                    TextField(
                      controller: signUpControllerUsername,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        filled: true,
                        fillColor: primaryColourWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - password input
                    TextField(
                      controller: signUpControllerPassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        filled: true,
                        fillColor: primaryColourWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== submit button
                    FilledButton(
                      onPressed: () async {
                        try {
                          final response = await supabase
                              .from('users')
                              .select('*')
                              .eq('username', signUpControllerUsername.text);

                          // the user is not in the database
                          if (response.isEmpty) {
                            final data = await supabase.from('users').insert({
                              'uuid': uuid.v1(),
                              'firstname': signUpControllerFirstName.text,
                              'lastname': signUpControllerLastName.text,
                              'username': signUpControllerUsername.text,
                              'password': signUpControllerPassword.text
                            });

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProductPage()));
                          }
                          // the user is in the database
                          else {
                            // TODO: alert that the username already exists
                          }
                        } catch (e) {
                          // print('Error: $e');
                          throw Exception('Error: $e');
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(primaryColourBlack),
                          padding: WidgetStatePropertyAll(
                              primaryPaddingAllWithIcon)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    // ================== create account link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: primaryColourBlack,
                            fontSize: paragraph,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: primaryColourBlack,
                              fontSize: paragraph,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
