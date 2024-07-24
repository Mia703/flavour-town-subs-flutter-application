import 'package:flavour_town_subs_flutter_application/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            // ================== BACKGROUND IMAGE ==================
            const Image(
              image: AssetImage('lib/assets/doordash-TLf0DXGtY6E-unsplash.jpg'),
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
            // ================== TEXT CONTAINER ==================
            Container(
              padding: primaryPaddingAll,
              margin: primaryMarginTopBottomPageView,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Easy Ordering',
                    style: TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerOne,
                        fontWeight: bold),
                  ),
                  primarySizedBox,
                  const Text(
                    'Order your favorite subs in just a few taps. Our user-friendly app makes it quick and convenient to place your order for pickup or delivery. Craving a sub? We’ve got you covered.',
                    style: TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerTwo,
                        fontWeight: bold),
                  ),
                  primarySizedBox,
                  Align(
                    alignment: Alignment.topRight,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(primaryColourRed),
                        padding:
                            WidgetStatePropertyAll(primaryPaddingAllWithIcon),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: primaryColourWhite,
                              fontSize: headerTwo,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: primaryColourWhite,
                            size: headerTwo,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
