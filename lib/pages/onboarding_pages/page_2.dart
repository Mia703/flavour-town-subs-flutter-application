import 'package:flutter/material.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
              image: AssetImage('lib/assets/pexels-toulouse-3098891.jpg'),
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
                    'Fresh Ingredients',
                    style: TextStyle(
                        color: primaryColourWhite,
                        fontSize: headerOne,
                        fontWeight: bold),
                  ),
                  primarySizedBox,
                  Text(
                    'We source only the finest ingredients for our subs. From crisp vegetables to premium meats, each bite is a testament to quality and freshness. Our commitment to excellence means you get a delicious sub every time.',
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
