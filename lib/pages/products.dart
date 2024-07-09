import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';

// ================== PRODUCTS PAGE ==================
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // List of items in our dropdown menu
  var items = [
    'Hot Subs',
    'Cold Subs',
    'Sides, Drinks, and Desserts',
  ];

  // Initial Selected Value
  String dropdownValue = 'Hot Subs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============== APP BAR ==============
      appBar: AppBar(
        backgroundColor: primaryBackgroundColour,
        title: Container(
          alignment: Alignment.center,
          child: const Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Flavour Town Subs',
                  style: TextStyle(
                      fontSize: headerTwo,
                      fontWeight: bold,
                      color: primaryColourRed,
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // ================== dropdown border
              Container(
                padding: primaryPadding,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: primaryColourLightBrown, width: 2, style: borderSolid),
                    bottom: BorderSide(
                        color: primaryColourLightBrown, width: 2, style: borderSolid),
                  ),
                ),
                // ================== dropdown menu
                child: DropdownButton(
                  // Initial Value
                  value: dropdownValue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              ),
              // TODO: ================== menu items GO HERE
            ],
          ),
          // ================== cart container
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              child: const Row(
                children: [
                  Text("View Cart"),
                  Text("\$12.99"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}