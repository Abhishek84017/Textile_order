import 'package:flutter/material.dart';

// Applications Palette
class Palette {
  // Primary color swatches
  static const Map<int, Color> primaryColorSwatch = {
    50: Color.fromRGBO(49, 39, 131, .1),
    100: Color.fromRGBO(49, 39, 131, .2),
    200: Color.fromRGBO(49, 39, 131, .3),
    300: Color.fromRGBO(49, 39, 131, .4),
    400: Color.fromRGBO(49, 39, 131, .5),
    500: Color.fromRGBO(49, 39, 131, .6),
    600: Color.fromRGBO(49, 39, 131, .7),
    700: Color.fromRGBO(49, 39, 131, .8),
    800: Color.fromRGBO(49, 39, 131, .9),
    900: Color.fromRGBO(49, 39, 131, 1),
  };

  // Primary color
  static const MaterialColor primaryColor =
      MaterialColor(0xff312783, primaryColorSwatch);

  // Text green color
  static const Color greenColor = Color(0xFF26a541);

  // Text green color
  static const Color redColor = Color(0xFFF44336);

  // Input hint color
  static const Color inputHintColor = Color(0xff495057);

  // Input border color
  static const Color inputBorderColor = Color.fromRGBO(0, 0, 0, .1);

  // Input divider color
  static const Color dividerColor = Color.fromRGBO(0, 0, 0, 0.2);

  // Input divider color
  static const Color dividerBlackColor = Color.fromRGBO(0, 0, 0, 1.0);

  // Stripe color
  static const Color greyStripeColor = Color.fromRGBO(238, 238, 238, 1.0);

  // Border color
  static const Color borderColor = Color.fromRGBO(238, 238, 238, 1.0);

  // Button overlayColor
  static const Color buttonOverlayColor = Color.fromRGBO(0, 0, 0, 0.05);

  // box shadow color
  static const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.1);

  // Cart orderIndicatorInactiveColor color
  static const Color orderIndicatorInactiveColor = Color(0xFF9A9A9A);

  // Cart gridProductCardBackground color
  static const Color gridProductCardBackground = Color(0xFFF5F5F7);

  // Cart buttonBackground color
  static const Color buttonBackgroundColor = Color(0xFFfa9f1d);

  // text color swatches
  static const Map<int, Color> blackColorSwatch = {
    50: Color.fromRGBO(42, 42, 42, .1),
    100: Color.fromRGBO(42, 42, 42, .2),
    200: Color.fromRGBO(42, 42, 42, .3),
    300: Color.fromRGBO(42, 42, 42, .4),
    400: Color.fromRGBO(42, 42, 42, .5),
    500: Color.fromRGBO(42, 42, 42, .6),
    600: Color.fromRGBO(42, 42, 42, .7),
    700: Color.fromRGBO(42, 42, 42, .8),
    800: Color.fromRGBO(42, 42, 42, .9),
    900: Color.fromRGBO(42, 42, 42, 1),
  };

  // text color
  static const MaterialColor blackColor =
      MaterialColor(0xff2A2A2A, blackColorSwatch);
}
