import 'package:flutter/material.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
              image: AssetImage(
                  'lib/assets/pexels-efrem-efre-2786187-23203214.jpg'),
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
                    'Customisable Subs',
                    style: TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerOne,
                        fontWeight: bold),
                  ),
                  primarySizedBox,
                  Text(
                    'At Flavour Town Subs, we believe in personalise dining. Customise your sub to perfection with out wide range of toppings, sauces, and bread options. Your sub, your way.',
                    style: TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerTwo,
                        fontWeight: bold),
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
