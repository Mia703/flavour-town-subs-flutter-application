import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/signup_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

// ================== LOGIN PAGE ==================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // retrieves inputs
  final TextEditingController loginControllerEmail = TextEditingController();
  final TextEditingController loginControllerPassword = TextEditingController();

  @override
  void dispose() {
    loginControllerEmail.dispose();
    loginControllerPassword.dispose();
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
                  'lib/assets/eaters-collective-Gg5-K-mJwuQ-unsplash.jpg'),
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
                    // ================== login form header
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: headerOne,
                        fontWeight: bold,
                        color: primaryColourBlack,
                      ),
                    ),
                    primarySizedBox,
                    // ================== login form sub-header
                    const Text(
                      'Login to start ordering online.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: headerTwo - 8,
                        color: primaryColourBlack,
                      ),
                    ),
                    const SizedBox(height: primarySpacer * 4),
                    // ================== login form - username input
                    TextField(
                      controller: loginControllerEmail,
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
                    // ================== login form - password input
                    TextField(
                      controller: loginControllerPassword,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph)),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== submit button
                    FilledButton(
                      onPressed: () {
                        // TODO: submit login form...
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductPage()));
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
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: primaryColourBlack,
                            fontSize: paragraph,
                          ),
                        ),
                        primarySizedBoxWidth,
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                          ),
                          child: const Text(
                            'Sign up',
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
