// ================== SIGN UP PAGE ==================
import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/components/products_grid_cold.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // retrieves inputs
  final TextEditingController signUpControllerName = TextEditingController();

  @override
  void dispose() {
    signUpControllerName.dispose();
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
                  color: primaryWhite,
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
                        color: primaryBlack,
                      ),
                    ),
                    primarySizedBox,
                    // ================== sign up form sub-header
                    const Text(
                      'Sign up to get started ordering online.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: headerTwo - 8,
                        color: primaryBlack,
                      ),
                    ),
                    const SizedBox(height: primarySpacer * 2),
                    // ================== sign up form - first name input
                    TextField(
                      controller: signUpControllerName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        filled: true,
                        fillColor: primaryWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - last name input
                    TextField(
                      controller: signUpControllerName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        filled: true,
                        fillColor: primaryWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - username input
                    TextField(
                      controller: signUpControllerName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        filled: true,
                        fillColor: primaryWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== sign up form - password input
                    TextField(
                      controller: signUpControllerName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        filled: true,
                        fillColor: primaryWhite,
                        labelStyle: TextStyle(fontSize: paragraph),
                      ),
                    ),
                    primarySizedBox,
                    primarySizedBox,
                    // ================== submit button
                    FilledButton(
                      onPressed: () {
                        // TODO: submit sign up form...
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductsGrid()));
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(primaryBlack),
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
                            color: primaryBlack,
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
                              color: primaryBlack,
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
