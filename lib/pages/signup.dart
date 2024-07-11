// ================== SIGN UP PAGE ==================
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
      // ================== APP BAR ==================
      appBar: AppBar(
        backgroundColor: primaryColourRed,
        foregroundColor: primaryBackgroundColour,
        title: const Text(
          'Flavour Town Subs',
          style: TextStyle(
              fontSize: headerTwo,
              fontWeight: bold,
              color: primaryBackgroundColour),
        ),
      ),
      // ================== BODY ==================
      body: Stack(
        children: <Widget>[
          // ================== background image ==================
          Image.network(
            '',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // ================== SIGN UP FORM CONTAINER ==================
          Center(
            child: Container(
              margin: primaryMarginAll * 2.5,
              padding: primaryPadding,
              decoration: const BoxDecoration(
                borderRadius: primaryBorderRadius,
                color: primaryColourLightBrown,
              ),
              child: Column(
                children: [
                  // ================== sign up form ==================
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: headerOne,
                      fontWeight: bold,
                      color: primaryFontColour,
                    ),
                  ),
                  textSpacer,
                  // ================== sign up form sub-header ==================
                  const Text(
                    'Sign up to start ordering online.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: headerTwo,
                      color: primaryFontColour,
                    ),
                  ),
                  const SizedBox(height: textSpacerNumber * 4),
                  // ================== sign up form - name input ==================
                  TextField(
                    controller: signUpControllerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      filled: true,
                      fillColor: primaryBackgroundColour,
                    ),
                  ),
                  textSpacer,
                  // ================== sign up form - submit button ==================
                  FilledButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(primaryFontColour),
                      ),
                      child: const Text('Submit')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
