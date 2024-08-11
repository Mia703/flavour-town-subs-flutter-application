import 'package:flavour_town_subs_flutter_application/components/product_page/product_detail_.dart';
import 'package:flavour_town_subs_flutter_application/main.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class ProductButton extends StatelessWidget {
  const ProductButton(
      {super.key,
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  final int id;
  final String name;
  final String description;
  final String price;
  final String image;

  final String imagePath = 'lib/assets/product_images/';

  @override
  Widget build(BuildContext context) {
    return Container(
      // changes width of slider boxes
      width: 280.00,
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
        // displays product's details in pop-up widget
        onPressed: () {
          showProductDetailWidget(context, currentUser, id, name, description,
              price, '$imagePath$image');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ================= IMAGE CONTAINER =================
            Image(
              image: AssetImage('$imagePath$image'),
              alignment: Alignment.center,
              fit: BoxFit.contain,
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
