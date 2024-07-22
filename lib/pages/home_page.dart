import 'package:flavour_town_subs_flutter_application/pages/onboarding_pages/page_1.dart';
import 'package:flavour_town_subs_flutter_application/pages/onboarding_pages/page_2.dart';
import 'package:flavour_town_subs_flutter_application/pages/onboarding_pages/page_3.dart';
import 'package:flavour_town_subs_flutter_application/pages/onboarding_pages/page_4.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PageView(
            controller: pageViewController,
            children: const [
              Page1(),
              Page2(),
              Page3(),
              Page4(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: primaryMargin, bottom: primaryMargin * 1.5),
              child: SmoothPageIndicator(
                controller: pageViewController,
                count: 4,
                effect: const ExpandingDotsEffect(
                  dotColor: primaryWhite,
                  activeDotColor: primaryWhite,
                  dotHeight: 20.0,
                  dotWidth: 20.0,
                  spacing: primaryMargin
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
