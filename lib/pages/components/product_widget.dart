import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImage;

  const ProductWidget(
      {super.key,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productImage});

  @override
  State<StatefulWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String imagePath = 'lib/db/product_images/';

  @override
  Widget build(BuildContext context) {
    String name = widget.productName;
    String description = widget.productDescription;
    double price = widget.productPrice;
    String image = imagePath + widget.productImage;
    return Container(
      margin: primaryMarginLeftRight,
      // TODO: wrap in a button so that you can add to cart
      child: Column(
        children: [
          Container(
            padding: primaryPaddingAll,
            color: primaryColourLightGrey,
            child: Column(
              children: [
                Image(image: AssetImage(image)),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: headerThree),
              ),
              Text(
                '\$$price',
                style: const TextStyle(fontSize: headerThree),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: paragraph),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
