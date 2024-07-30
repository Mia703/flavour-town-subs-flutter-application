import 'package:flutter/material.dart';

// ================= PRIMARY COLOURS =================
const primaryColourBlack = Colors.black;
const primaryColourWhite = Colors.white;
const primaryColourRed = Color.fromRGBO(184, 0, 0, 1);
const primaryColourYellow = Color.fromRGBO(255, 190, 0, 1);
const primaryColourBlue = Color.fromRGBO(0, 102, 164, 1);
const primaryColourLightGrey = Color.fromRGBO(231, 231, 231, 1);
const primaryColourDarkGrey = Color.fromRGBO(212, 212, 212, 1);
const primaryColourTransparent = Colors.transparent;
const primaryColourOverlay = Color.fromRGBO(61, 61, 61, 0.623);

// ================= PRIMARY FONT SIZES =================
const headerOne = 32.0;
const headerTwo = 28.0;
const headerThree = 20.0;
const paragraph = 16.0;

// ================= PRIMARY FONT WEIGHT =================
const regular = FontWeight.normal;
const medium = FontWeight.w500;
const semibold = FontWeight.w600;
const bold = FontWeight.bold;
const italic = FontStyle.italic;
const underline = TextDecoration.underline;

// ================= PRIMARY LAYOUT =================

EdgeInsets addPadding(String type, double padding) {
  switch (type) {
    case 'top':
      {
        return EdgeInsets.only(top: padding);
      }
    case 'bottom':
      {
        return EdgeInsets.only(bottom: padding);
      }
    case 'left':
      {
        return EdgeInsets.only(left: padding);
      }
    case 'right':
      {
        return EdgeInsets.only(right: padding);
      }
    case 'tb':
      {
        return EdgeInsets.only(top: padding, bottom: padding);
      }
    case 'lr':
      {
        return EdgeInsets.only(right: padding, left: padding);
      }
    default:
      {
        return EdgeInsets.all(padding);
      }
  }
}

EdgeInsets addMargin(String type, double margin) {
  switch (type) {
    case 'top':
      {
        return EdgeInsets.only(top: margin);
      }
    case 'bottom':
      {
        return EdgeInsets.only(bottom: margin);
      }
    case 'left':
      {
        return EdgeInsets.only(left: margin);
      }
    case 'right':
      {
        return EdgeInsets.only(right: margin);
      }
    case 'tb':
      {
        return EdgeInsets.only(top: margin, bottom: margin);
      }
    case 'lr':
      {
        return EdgeInsets.only(right: margin, left: margin);
      }
    default:
      {
        return EdgeInsets.all(margin);
      }
  }
}

BorderRadius addBorderRadius(String type, double radius) {
  switch (type) {
    case 'tl':
      {
        return BorderRadius.only(topLeft: Radius.circular(radius));
      }
    case 'tr':
      {
        return BorderRadius.only(topRight: Radius.circular(radius));
      }
    case 'bl':
      {
        return BorderRadius.only(bottomLeft: Radius.circular(radius));
      }
    case 'br':
      {
        return BorderRadius.only(bottomRight: Radius.circular(radius));
      }
    default:
      {
        return BorderRadius.all(Radius.circular(radius));
      }
  }
}

const borderSolid = BorderStyle.solid;

SizedBox addSpacer(String type, double amount) {
  switch (type) {
    case 'height':
      {
        return SizedBox(
          height: amount,
        );
      }
    default:
      {
        return SizedBox(
          width: amount,
        );
      }
  }
}
