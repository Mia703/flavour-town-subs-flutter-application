import 'package:flavour_town_subs_flutter_application/database/supabase.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flavour_town_subs_flutter_application/models/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void showProductDetailWidget(BuildContext context, CurrentUser user, int id,
    String name, String description, String price, String image) {
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
            child: SingleChildScrollView(
              // layout builder = builds something that depends on the parent widget's size
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    // ================= PRODUCT IMAGE
                    Image(image: AssetImage(image)),
                    // ================= PRODUCT NAME
                    Text(
                      name,
                      style: const TextStyle(fontSize: headerTwo),
                      textAlign: TextAlign.center,
                    ),
                    addSpacer('height', 20.00),
                    // ================= PRODUCT DESCRIPTION
                    Text(
                      '$description.',
                      style: const TextStyle(
                        fontSize: paragraph,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    addSpacer('height', 45.00),
                    // ================= ADD TO CART BUTTON + ITEM PRICE
                    // constrained box = similar to a sized box
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: constraints.maxHeight),
                      child: Flexible(
                        fit: FlexFit.loose,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FilledButton(
                            onPressed: () async {
                              // adds item to cart and updates badge icon
                              addToCart(supabase, context, user, id,
                                  double.parse(price));
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(primaryColourBlue),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  'Add to Cart',
                                  style: TextStyle(fontSize: paragraph),
                                ),
                                Text(
                                  '\$$price',
                                  style: const TextStyle(fontSize: headerThree),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ));
}
