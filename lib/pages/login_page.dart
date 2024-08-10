import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/pages/signup_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _loginControllerUsername;
  late TextEditingController _loginControllerPassword;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _loginControllerUsername = TextEditingController();
    _loginControllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginControllerUsername.dispose();
    _loginControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // ================= BACKGROUND IMAGE =================
            const Image(
              image: AssetImage(
                  'lib/assets/onboarding_images/eaters-collective-Gg5-K-mJwuQ-unsplash.jpg'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // ================= OVERLAY =================
            Container(
              width: double.infinity,
              height: double.infinity,
              color: primaryColourOverlay,
            ),
            // ================= LOGIN FORM =================
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: addPadding('default', 16.00),
                  margin: addMargin('default', 20.00),
                  decoration: BoxDecoration(
                    color: primaryColourYellow.withOpacity(0.8),
                    borderRadius: addBorderRadius('default', 20.00),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ================= login header =================
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: headerOne,
                          color: primaryColourBlack,
                          fontWeight: bold,
                        ),
                      ),
                      // ================= login subheader =================
                      const Text(
                        'Login to start ordering.',
                        style: TextStyle(
                            fontSize: paragraph, color: primaryColourBlack),
                        textAlign: TextAlign.center,
                      ),
                      addSpacer('height', 16.00),
                      // ================= login username =================
                      TextField(
                        controller: _loginControllerUsername,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================= login password =================
                      TextField(
                        controller: _loginControllerPassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================= login submit button =================
                      FilledButton(
                        onPressed: () {
                          loginUser(
                              supabase,
                              context,
                              _loginControllerUsername.text,
                              _loginControllerPassword.text);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(primaryColourBlue),
                        ),
                        child: const Text(
                          'Submit',
                          style:
                              TextStyle(fontSize: paragraph, fontStyle: italic),
                        ),
                      ),
                      addSpacer('height', 5.00),
                      // ================= navigate to sign up page =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()));
                            },
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  addPadding('default', 0)),
                              backgroundColor: const WidgetStatePropertyAll(
                                  primaryColourTransparent),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: primaryColourBlack,
                                  decoration: underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
