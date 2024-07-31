import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class OnboardingOrientation extends StatelessWidget {
  const OnboardingOrientation(
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 1 : 1,
              children: [
                Container(
                  color: primaryColourBlack,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
