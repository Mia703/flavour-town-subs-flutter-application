import 'package:flutter/material.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

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
                image:
                    AssetImage('lib/assets/pexels-roman-odintsov-5836776.jpg'),
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Flavour Town!',
                      style: TextStyle(
                          color: primaryColourWhite,
                          fontSize: headerOne,
                          fontWeight: bold),
                    ),
                    primarySizedBox,
                    Text(
                      'Experience the ultimate sub with fresh ingredients, mouth-watering flavours, and a unique taste that keeps you coming back for more.',
                      style: TextStyle(
                          color: primaryColourWhite,
                          fontSize: headerTwo,
                          fontWeight: bold),
                    ),
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
