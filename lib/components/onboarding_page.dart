import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {super.key,
      required this.title,
      required this.description,
      required this.imagePath,
      required this.hasButton});

  final String title;
  final String description;
  final String imagePath;
  final bool hasButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              // ================= BACKGROUND IMAGE =================
              Image(
                image: AssetImage(imagePath),
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
              // ================= TEXT CONTAINER =================
              Container(
                padding: addPadding('default', 16.00),
                margin: addMargin('bottom', 35.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerOne,
                        fontWeight: bold,
                      ),
                    ),
                    addSpacer('height', 5.00),
                    Text(
                      description,
                      style: const TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerThree,
                        fontWeight: bold,
                      ),
                    ),
                    addSpacer('height', 5.00),
                    // ================= ORDER NOW BTN =================
                    hasButton
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(primaryColourRed),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Order Online',
                                      style: TextStyle(
                                        color: primaryColourWhite,
                                        fontSize: paragraph,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: primaryColourWhite,
                                      size: headerTwo,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
