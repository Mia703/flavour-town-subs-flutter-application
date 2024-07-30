import 'package:flavour_town_subs_flutter_application/components/product_detail_.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class ProductButton extends StatelessWidget {
  const ProductButton(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  final String name;
  final String description;
  final String price;
  final String image;

  final String imagePath = 'lib/assets/product_images/';

  @override
  Widget build(BuildContext context) {
    return Container(
      // FIXME: after resizing images, make width smaller
      width: 300.00,
      margin: addMargin('lr', 8.00),
      child: OutlinedButton(
        // defines the style round the button
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: primaryColourDarkGrey,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: addBorderRadius('default', 0),
          ),
          padding: addPadding('default', 10.00),
        ),
        onPressed: () {
          // TODO: on click add to cart list
          showProductDetailWidget(
              context, name, description, '\$$price', '$imagePath$image');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ================= IMAGE CONTAINER =================
            Container(
              // TODO: remove or keep?
              // color: primaryColourLightGrey,
              child: Image(
                image: AssetImage('$imagePath$image'),
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            addSpacer('height', 10.00),
            // ================= PRODUCT NAME & PRICE CONTAINER =================
            Container(
              padding: addPadding('lr', 5.00),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ================= product name
                  Flexible(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: paragraph,
                        color: primaryColourBlack,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  addSpacer('width', 10.00),
                  // ================= product price
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: headerTwo,
                      color: primaryColourBlue,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
            // ================= PRODUCT DESC CONTAINER =================
            Container(
              padding: addPadding('lr', 5.00) + addPadding('top', 5.00),
              child: Flexible(
                // ================= PRODUCT DESC
                child: Text(
                  '$description.',
                  style: const TextStyle(
                    fontSize: paragraph - 3,
                    color: primaryColourBlack,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
