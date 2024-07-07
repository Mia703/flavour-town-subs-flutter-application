import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // this is the root of your application.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavour Town Subs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // sets the background color
        scaffoldBackgroundColor: Colors.white,
        // set the font family to googl's 'anybody' font
        textTheme: GoogleFonts.anybodyTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomePage(),
    );
  }
}

// ================== HOME PAGE ==================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 73, 36, 1),
          title: Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Flavour Town Subs',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => NextPage()),
                //     );
                //   },
                //   icon: const Icon(
                //     Icons.menu,
                //     color: Colors.white,
                //     size: 30.0,
                //   ),
                // ),
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        // TODO: change to loginPage
                        MaterialPageRoute(builder: (context) => ProductsPage()),
                      );
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ================== image header
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(241, 73, 36, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1481425233433-eee122de7dec?w=1200&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTZ8fHxlbnwwfHx8fHw%3D',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      left: 0,
                      // child: Image.network(
                      //     'https://images.unsplash.com/photo-1481732460663-268c19595def?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      child: Text("add grain here"),
                    ),
                    const Positioned(
                        bottom: 12,
                        left: 12,
                        child: Text(
                          'Deliciousness For All',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        )),
                  ],
                ),
              ),
              // ================== header text
              Container(
                padding: const EdgeInsets.all(12.0),
                child: const SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bite into Flavour Town!',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(91, 50, 14, 1),
                        ),
                      ),
                      SizedBox(height: 5.00),
                      Text(
                        "Welcome to Flavour Town Subs, where every bite is a trip to deliciousness! Our subs are more than just sandwiches; they are culinary journeys crafted to excite your taste buds and leave you craving more. Whether you're in the mood for something hot and hearty or cool and refreshing, we've got the perfect sub for you.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(91, 50, 14, 1),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // ================== highlight
              Container(
                padding: const EdgeInsets.all(12.0),
                color: Color.fromRGBO(255, 190, 0, 1),
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'sandwiches made to delight',
                      style: TextStyle(
                          color: Color.fromRGBO(91, 50, 14, 1),
                          fontWeight: FontWeight.bold),
                    )),
              ),
              // ================== menu
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const Column(
                        children: [
                          Text(
                            "Hot Subs that Sizzle",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(91, 50, 14, 1),
                            ),
                          ),
                          Text('image'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const Column(
                        children: [
                          Text(
                            "Cool and Crisp Cold Subs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(91, 50, 14, 1),
                            ),
                          ),
                          Text('image'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const Column(
                        children: [
                          Text(
                            "Sides, Drinks, and Desserts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(91, 50, 14, 1),
                            ),
                          ),
                          Text('image'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: FilledButton(
                        onPressed: () {},
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('View Our Menu'),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ================== download app
              Container(
                padding: const EdgeInsets.all(12.0),
                child: const SizedBox(
                  width: double.infinity,
                ),
              ),
              // ================== footer
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 168, 107, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Text(
                        'Flavour Town Subs',
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('About Us'),
                              Text('Contact Us'),
                              Text('Locations'),
                              Text('Order Online'),
                            ],
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Gift Cards'),
                              Text('Merchandise'),
                              Text('Catering'),
                              Text('Mobile App'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Terms of Use'),
                            ],
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Privacy Policy'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Instagram'),
                              Text('TikTok'),
                            ],
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          Column(
                            children: [
                              Text('Facebook'),
                              Text('LinkedIn'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"Flavour Town Subs" is a registered trademark of Flavour Town, LLC. All Rights Reserved.',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// ================== LOGIN PAGE ==================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // retrieves inputs
  final TextEditingController loginController_email = TextEditingController();
  final TextEditingController loginConroller_password = TextEditingController();

  @override
  void dispose() {
    loginController_email.dispose();
    loginConroller_password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 73, 36, 1),
        title: const Text(
          'Flavour Town Subs',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // ================== background image
          Image.network(
            'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTh8fHxlbnwwfHx8fHw%3D',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // ================== login form
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 190, 0, 1),
              ),
              child: Column(
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(91, 50, 14, 1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Login to access flavour on another dimension.',
                    style: TextStyle(color: Color.fromRGBO(91, 50, 14, 1)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // ================== login form input
                  TextField(
                    controller: loginController_email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: loginConroller_password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ================== submit button
                  FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromRGBO(0, 102, 164, 1)),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(loginController_email.text +
                                  " " +
                                  loginConroller_password.text),
                            );
                          });
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // ================== link to account creation
                  const Text('Don\'t Have an Account? Create one here.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================== SIGN UP PAGE ==================

// ================== PRODUCTS PAGE ==================
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // List of items in our dropdown menu
  var items = [
    'Hot Subs',
    'Cold Subs',
    'Sides, Drinks, and Desserts',
  ];

  // Initial Selected Value
  String dropdownValue = 'Hot Subs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: const Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Flavour Town Subs',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(241, 73, 36, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              // ================== dropdown menu
              Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 20, right: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
                    bottom: BorderSide(
                        color: Colors.blue, width: 2, style: BorderStyle.solid),
                  ),
                ),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownValue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              ),
              // TODO: ================== menu items GO HERE
            ],
          ),
          // ================== cart container
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
                child: const Row(
                  children: [
                    Text("View Cart"),
                    Text("\$12.99"),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}
