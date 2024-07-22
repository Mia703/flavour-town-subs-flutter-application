// ============== PRIMARY COLOURS ==============
import 'package:flutter/material.dart';

const primaryBlack = Colors.black;
const primaryWhite = Color.fromRGBO(243, 238, 238, 1);
const primaryColourRed = Color.fromRGBO(184, 0, 0, 1);
const primaryColourLightGrey = Color.fromRGBO(231, 231, 231, 1);
const primaryColourTransparent = Colors.transparent;
const primaryOverlay = Color.fromRGBO(61, 61, 61, 0.623);

// ============== PRIMARY FONT SIZES ==============
const headerOne = 32.0;
const headerTwo = 28.0;
const headerThree = 18.0;
const paragraph = 18.0;
const attribution = 12.0;

// ============== PRIMARY FONT WEIGHT ==============
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semibold = FontWeight.w600;
const bold = FontWeight.bold;
const italic = FontStyle.italic;

// ============== PRIMARY LAYOUT ==============
// padding
const primaryPadding = 16.0;
const primaryPaddingAll = EdgeInsets.all(primaryPadding);
const primaryPaddingAllWithIcon = EdgeInsets.only(
  top: primaryPadding,
  bottom: primaryPadding,
  left: primaryPadding + 15,
  right: primaryPadding + 15,
);

// margin
const primaryMargin = 16.0;
const primaryMarginAll = EdgeInsets.all(primaryMargin);
const primaryMarginTopBottom =
    EdgeInsets.only(top: primaryMargin, bottom: primaryMargin);
const primaryMarginLeftRight =
    EdgeInsets.only(left: primaryMargin, right: primaryMargin);
const primaryMarginBottom = EdgeInsets.only(bottom: primaryMargin);

// pageview on onboarding pages
const primaryMarginTopBottomPageView =
    EdgeInsets.only(top: primaryMargin, bottom: primaryMargin * 4);

// border radius
const primaryRadius = Radius.circular(20.0);
const primaryBorderRadius = BorderRadius.all(primaryRadius);
const primaryBorderRadiusTop =
    BorderRadius.only(topLeft: primaryRadius, topRight: primaryRadius);
const primaryBorderRadiusBottom =
    BorderRadius.only(bottomLeft: primaryRadius, bottomRight: primaryRadius);

// border
const borderSolid = BorderStyle.solid;

// spacers
const primarySpacer = 10.00;
const primarySizedBox = SizedBox(height: primarySpacer);
const primarySizedBoxWidth = SizedBox(width: primarySpacer);
const primarySizedBoxFooter = SizedBox(width: primarySpacer * 10);
