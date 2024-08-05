import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/product_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _signupFirstName;
  late TextEditingController _signupLastName;
  late TextEditingController _signupUsername;
  late TextEditingController _signupPassword;

  final supabase = Supabase.instance.client;

  Future<void> _signUpUser(BuildContext context, String firstName,
      String lastName, String username, String password) async {
    try {
      print('check if the user already exists');
      final response = await supabase
          .from('users')
          .select('username')
          .eq('username', username);

      if (response.isEmpty) {
        print(
            'the user does not exists in the table. add the user to the table');

        // by default just .insert() doesn't return anything
        // adding select returns the inserted data on success?
        var id = uuid.v1();
        final data = await supabase.from('users').insert({
          'uuid': id,
          'firstname': firstName,
          'lastname': lastName,
          'username': username,
          'password': password,
        }).select();

        if (data.isEmpty) {
          print('signup: data insertion was not successful');

          if (context.mounted) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text(
                      'Sorry!',
                      style: TextStyle(fontSize: paragraph, fontWeight: bold),
                    ),
                    content: Text(
                      'It seems your sign up was unsuccessful. Please try again.',
                      style: TextStyle(fontSize: paragraph),
                    ),
                  );
                });
          }
        } else {
          print('data insertion was successful');

          print('update global user object');
          currentUser.setUUID(id);
          currentUser.setFirstName(firstName);
          currentUser.setLastName(lastName);
          currentUser.setUsername(username);
          currentUser.setPassword(password);

          print('navigate to products page');
          if (context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProductPage()));
          }
        }
      } else {
        print('the user exists in the table. direct to login page');

        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text(
                    'Username Already Exists',
                    style: TextStyle(fontSize: paragraph, fontWeight: bold),
                  ),
                  content: Text(
                    'The username you\'ve entered already exists. Please consider logging in or entering a new username.',
                    style: TextStyle(fontSize: paragraph),
                  ),
                );
              });
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    _signupFirstName = TextEditingController();
    _signupLastName = TextEditingController();
    _signupUsername = TextEditingController();
    _signupPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _signupFirstName.dispose();
    _signupLastName.dispose();
    _signupUsername.dispose();
    _signupPassword.dispose();
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
                  'lib/assets/onboarding_images/pexels-ahmed-rabea-2883687-4559174.jpg'),
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
            // ================= SIGN UP FORM =================
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
                    children: <Widget>[
                      // ================= sign up header =================
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: headerOne,
                          color: primaryColourBlack,
                          fontWeight: bold,
                        ),
                      ),
                      // ================= sign up subheader =================
                      const Text(
                        'Create an account to start ordering.',
                        style: TextStyle(
                            fontSize: paragraph, color: primaryColourBlack),
                        textAlign: TextAlign.center,
                      ),
                      addSpacer('height', 16.00),
                      // ================= sign up first name =================
                      TextField(
                        controller: _signupFirstName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================= sign up last name =================
                      TextField(
                        controller: _signupLastName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================= sign up username =================
                      TextField(
                        controller: _signupUsername,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================= sign up password =================
                      TextField(
                        controller: _signupPassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          filled: true,
                          fillColor: primaryColourWhite,
                          labelStyle: TextStyle(fontSize: paragraph),
                        ),
                      ),
                      addSpacer('height', 16.00),
                      // ================ sign up submit button ================
                      FilledButton(
                        onPressed: () {
                          _signUpUser(
                              context,
                              _signupFirstName.text,
                              _signupLastName.text,
                              _signupUsername.text,
                              _signupPassword.text);
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(primaryColourBlue),
                        ),
                        child: const Text(
                          'Submit',
                          style:
                              TextStyle(fontSize: paragraph, fontStyle: italic),
                        ),
                      ),
                      // ================ navigate to login page ================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  addPadding('default', 0)),
                              backgroundColor: const WidgetStatePropertyAll(
                                  primaryColourTransparent),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: primaryColourBlack,
                                decoration: underline,
                              ),
                            ),
                          ),
                        ],
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
