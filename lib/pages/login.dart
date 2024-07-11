import 'package:flavour_town_subs_flutter_application/pages/signup.dart';
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
      // ================== APP BAR ==================
      appBar: AppBar(
        backgroundColor: primaryColourRed,
        foregroundColor: primaryBackgroundColour,
        title: const Text(
          'Flavour Town Subs',
          style: TextStyle(
            fontSize: headerTwo,
            fontWeight: bold,
            color: primaryBackgroundColour,
          ),
        ),
      ),
      // ================== BODY ==================
      body: Stack(
        children: <Widget>[
          // ================== background image
          Image.network(
            // FIXME: change to internal image
            'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTh8fHxlbnwwfHx8fHw%3D',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // ================== LOGIN FORM CONTAINER ==================
          Center(
            child: Container(
              margin: primaryMarginAll * 2.5,
              padding: primaryPadding,
              decoration: const BoxDecoration(
                borderRadius: primaryBorderRadius,
                color: primaryColourYellow,
              ),
              child: Column(
                children: [
                  // ================== login form header
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: headerOne,
                      fontWeight: bold,
                      color: primaryFontColour,
                    ),
                  ),
                  textSpacer,
                  // ================== login form sub-header
                  const Text(
                    'Login to access flavour on another dimension.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: headerTwo,
                      color: primaryFontColour,
                    ),
                  ),
                  const SizedBox(height: textSpacerNumber * 4),
                  // ================== login form - email input
                  TextField(
                    controller: loginControllerEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      filled: true,
                      fillColor: primaryBackgroundColour,
                    ),
                  ),
                  textSpacer,
                  // ================== login form - password input
                  TextField(
                    controller: loginControllerPassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      filled: true,
                      fillColor: primaryBackgroundColour,
                    ),
                  ),
                  const SizedBox(height: textSpacerNumber * 2),
                  // ================== submit button
                  FilledButton(
                    onPressed: () {
                      // TODO: do something...
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(primaryFontColour),
                    ),
                    child: const Text('Submit'),
                  ),
                  textSpacer,
                  // ================== create account link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: primaryFontColour,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                primaryColourTransparent),
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: primaryFontColour,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
