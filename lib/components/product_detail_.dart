import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

void showProductDetailWidget(BuildContext context, String name,
    String description, String price, String image) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 5,
      builder: (context) => Container(
            width: double.infinity,
            padding: addPadding('default', 16.00),
            constraints: BoxConstraints(
              // max height is 80% of the device's height
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              children: [
                // ================= PRODUCT IMAGE
                Image(image: AssetImage(image)),
                // ================= PRODUCT NAME
                Text(
                  name,
                  style: const TextStyle(fontSize: headerTwo),
                ),
                // ================= PRODUCT DESCRIPTION
                Text(
                  '$description.',
                  style: const TextStyle(
                    fontSize: paragraph,
                  ),
                ),
                // ================= ADD TO CART BUTTON + PRICE
                Flexible(
                  fit: FlexFit.loose,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FilledButton(
                      // TODO: onpressed add item to cart (supabase) & updated badge counter
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primaryColourBlue),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(fontSize: headerThree),
                          ),
                          const Text('Add to Cart'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
}
