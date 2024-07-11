// ============== PRIMARY COLOURS ==============
import 'package:flutter/material.dart';

const primaryFontColour = Color.fromRGBO(91, 50, 14, 1);
const primaryBackgroundColour = Colors.white;

const primaryColourRed = Color.fromRGBO(241, 73, 36, 1);
const primaryColourYellow = Color.fromRGBO(255, 190, 0, 1);
const primaryColourLightBrown = Color.fromRGBO(237, 219, 195, 1);
const primaryColourTransparent = Colors.transparent;

// ============== PRIMARY FONT SIZES ==============
const headerOne = 32.0;
const headerTwo = 20.0;
const headerThree = 18.0;
const paragraph = 16.0;
const attribution = 12.0;

// ============== PRIMARY FONT WEIGHT ==============
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semibold = FontWeight.w600;
const bold = FontWeight.bold;
const italic = FontStyle.italic;

// ============== PRIMARY LAYOUT ==============
// padding
const primaryPaddingNumber = 16.0;
const primaryPadding = EdgeInsets.all(primaryPaddingNumber);
const primaryPaddingWithIcon = EdgeInsets.only(
  top: 10,
  bottom: 10,
  left: 16,
  right: 10,
);

// margin
const primaryMarginNumber = 12.0;
const primaryMarginAll = EdgeInsets.all(primaryMarginNumber);
const primaryMarginTopBottom =
    EdgeInsets.only(top: primaryMarginNumber, bottom: primaryMarginNumber);
const primaryMarginLeftRight =
    EdgeInsets.only(left: primaryMarginNumber, right: primaryMarginNumber);
const primaryMarginBottom = EdgeInsets.only(bottom: 16.0);

// border radius
const primaryBorderRadius = BorderRadius.all(Radius.circular(20.0));
const primaryBorderRadiusTop = BorderRadius.only(
    topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0));
const primaryBorderRadiusBottom = BorderRadius.only(
    bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0));

// border
const borderSolid = BorderStyle.solid;

// spacers
const textSpacerNumber = 10.00;
const textSpacer = SizedBox(height: textSpacerNumber);
const footerTextSpacer = SizedBox(width: textSpacerNumber * 10);
