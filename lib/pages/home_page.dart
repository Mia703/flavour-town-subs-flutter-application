import 'package:flavour_town_subs_flutter_application/components/onboarding_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flavour_town_subs_flutter_application/components/onboarding_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageViewController,
              children: const [
                OnboardingPage(
                  title: 'Welcome to Flavour Town Subs',
                  description:
                      'Experience the ultimate sub with fresh ingredients, mouth-watering flavours, and a unique taste that keeps you coming back for more.',
                  imagePath:
                      'lib/assets/onboarding_images/pexels-roman-odintsov-5836776.jpg',
                  hasButton: false,
                ),
                OnboardingPage(
                  title: 'Fresh Ingredients',
                  description:
                      'We source only the finest ingredients for our subs. From crisp vegetables to premium meats, each bite is a testament to quality and freshness. Our commitment to excellence means you get a delicious sub every time.',
                  imagePath:
                      'lib/assets/onboarding_images/pexels-toulouse-3098891.jpg',
                  hasButton: false,
                ),
                OnboardingPage(
                  title: 'Customisable Subs',
                  description:
                      'At Flavour Town Subs, we believe in personalise dining. Customise your sub to perfection with out wide range of toppings, sauces, and bread options. Your sub, your way.',
                  imagePath:
                      'lib/assets/onboarding_images/pexels-efrem-efre-2786187-23203214.jpg',
                  hasButton: false,
                ),
                // OnboardingOrientation(
                //   title: 'testpage',
                //   description: 'test description',
                //   imagePath:
                //       'lib/assets/onboarding_images/pexels-efrem-efre-2786187-23203214.jpg',
                //   hasButton: false,
                // ),
                OnboardingPage(
                  title: 'Easy Ordering',
                  description:
                      'Order your favourite subs in just a few taps. Our user-friendly app makes it quick and convenient to place your order for pickup or delivery. Craving a sub? We’ve got you covered.',
                  imagePath:
                      'lib/assets/onboarding_images/doordash-TLf0DXGtY6E-unsplash.jpg',
                  hasButton: true,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: addMargin('default', 16.00),
                child: SmoothPageIndicator(
                  controller: _pageViewController,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    dotColor: primaryColourWhite,
                    activeDotColor: primaryColourWhite,
                    dotHeight: 14.00,
                    dotWidth: 14.00,
                    spacing: 14.00,
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
