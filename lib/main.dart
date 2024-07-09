import 'package:flavour_town_subs_flutter_application/pages/login.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: primaryBackgroundColour,
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
        // ===================== APP BAR =====================
        appBar: AppBar(
          backgroundColor: primaryColourRed,
          title: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              // ================== logo
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: const ButtonStyle(
                    overlayColor:
                        WidgetStatePropertyAll(primaryColourTransparent)),
                child: const Text(
                  'Flavour Town Subs',
                  style: TextStyle(
                      fontSize: headerTwo,
                      fontWeight: bold,
                      color: primaryBackgroundColour),
                ),
              ),
              // ================== order online button
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryFontColour),
                    padding: WidgetStatePropertyAll(primaryPaddingWithIcon)),
                child: const Row(
                  children: [
                    Text(
                      'Order Online',
                      style: TextStyle(fontSize: paragraph),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: headerTwo,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // ===================== BODY =====================
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ===================== image header container =====================
              Container(
                padding: const EdgeInsets.only(
                  top: primaryPaddingNumber,
                  left: primaryPaddingNumber,
                  right: primaryPaddingNumber,
                  bottom: primaryPaddingNumber + 10,
                ),
                margin: primaryMarginBottom,
                decoration: const BoxDecoration(
                  color: primaryColourRed,
                  borderRadius: primaryBorderRadiusBottom,
                ),
                child: Stack(
                  children: [
                    // ================== image header
                    ClipRRect(
                      borderRadius: primaryBorderRadius,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1481425233433-eee122de7dec?w=1200&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTZ8fHxlbnwwfHx8fHw%3D',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // ================== image header grain
                    const Positioned(
                      top: 0,
                      left: 0,
                      // child: Image.network(
                      //     'https://images.unsplash.com/photo-1481732460663-268c19595def?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      child: Text("add grain here"),
                    ),
                    // ================== image header text
                    const Positioned(
                      bottom: 12,
                      left: 12,
                      child: Text(
                        'Deliciousness For All',
                        style: TextStyle(
                          color: primaryBackgroundColour,
                          fontWeight: bold,
                          fontSize: headerOne,
                          fontStyle: italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ===================== header container =====================
              Container(
                margin: primaryMarginTopBottom,
                padding: primaryPadding,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // ================== header text
                    Text(
                      'Bite into Flavour Town!',
                      style: TextStyle(
                        fontSize: headerTwo,
                        color: primaryFontColour,
                        fontWeight: semibold,
                      ),
                    ),
                    textSpacer,
                    // ================== header body
                    Text(
                      "Welcome to Flavour Town Subs, where every bite is a trip to deliciousness! Our subs are more than just sandwiches; they are culinary journeys crafted to excite your taste buds and leave you craving more. Whether you're in the mood for something hot and hearty or cool and refreshing, we've got the perfect sub for you.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: primaryFontColour,
                      ),
                    ),
                  ],
                ),
              ),
              // ===================== menu container =====================
              Center(
                child: Column(
                  children: [
                    // ================== menu item one
                    Container(
                      margin: primaryMarginTopBottom,
                      padding: primaryPadding,
                      child: const Column(
                        children: [
                          Text(
                            "Hot Subs that Sizzle",
                            style: TextStyle(
                              fontWeight: bold,
                              color: primaryFontColour,
                            ),
                          ),
                          // TODO: add image
                          Text('image'),
                        ],
                      ),
                    ),
                    // ================== menu item two
                    Container(
                      margin: primaryMarginTopBottom,
                      padding: primaryPadding,
                      child: const Column(
                        children: [
                          Text(
                            "Cool and Crisp Cold Subs",
                            style: TextStyle(
                              fontWeight: bold,
                              color: primaryFontColour,
                            ),
                          ),
                          // TODO: add image
                          Text('image'),
                        ],
                      ),
                    ),
                    // ================== menu item three
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const Column(
                        children: [
                          Text(
                            "Sides, Drinks, and Desserts",
                            style: TextStyle(
                              fontWeight: bold,
                              color: primaryFontColour,
                            ),
                          ),
                          // TODO: add image
                          Text('image'),
                        ],
                      ),
                    ),
                    // ================== view menu button
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: primaryMarginLeftRight,
                        child: FilledButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(primaryPaddingWithIcon),
                            backgroundColor:
                                WidgetStatePropertyAll(primaryFontColour),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('View Our Menu'),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ===================== download app container =====================
              // TODO: insert download app container
              // ===================== footer container =====================
              Container(
                margin: const EdgeInsets.only(
                  top: primaryMarginNumber + primaryMarginNumber,
                ),
                padding: primaryPadding,
                decoration: const BoxDecoration(
                  color: primaryColourYellow,
                  borderRadius: primaryBorderRadiusTop,
                ),
                child: const Center(
                  child: Column(
                    children: [
                      // ================== footer header
                      Text(
                        'Flavour Town Subs',
                        style: TextStyle(
                            fontSize: headerOne,
                            fontWeight: bold,
                            color: primaryFontColour),
                      ),
                      textSpacer,
                      // ================== footer "links"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'About Us',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Locations',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Order Online',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                            ],
                          ),
                          footerTextSpacer,
                          Column(
                            children: [
                              Text(
                                'Gift Cards',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Merchandise',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Catering',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'Mobile App',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                            ],
                          ),
                        ],
                      ),
                      textSpacer,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Terms of Use',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                            ],
                          ),
                          footerTextSpacer,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
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
                            // FIXME: fix the centering of the elements
                            children: [
                              Text(
                                'Instagram',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'TikTok',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                            ],
                          ),
                          footerTextSpacer,
                          Column(
                            // FIXME: fix the centering of the elements
                            children: [
                              Text(
                                'Facebook',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                              ),
                              Text(
                                'LinkedIn',
                                style: TextStyle(
                                    fontWeight: semibold,
                                    color: primaryFontColour),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      textSpacer,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '"Flavour Town Subs" is a registered trademark of Flavour Town, LLC. All Rights Reserved.',
                              style: TextStyle(
                                fontSize: attribution,
                                fontWeight: semibold,
                                color: primaryFontColour,
                              ),
                              textAlign: TextAlign.center,
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
        ));
  }
}