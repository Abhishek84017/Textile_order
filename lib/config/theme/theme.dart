import 'package:textile/constants/app_constants.dart';
import 'package:textile/utils/palette.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  // TextScaleFactor
  static const double textScaleFactor = 1.0;

  // App theme data
  static ThemeData theme() {
    return ThemeData(
      // pageTransitionsTheme: PageTransitionsTheme(builders: {
      //   TargetPlatform.android: AndroidTransition(),
      // }),
      primarySwatch: Palette.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: kFontFamily,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all<Color>(Palette.buttonOverlayColor),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline1: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        bodyText1: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        button: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        caption: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline2: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline3: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline4: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline5: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        headline6: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        overline: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        subtitle1: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
        subtitle2: TextStyle(
          height: textScaleFactor,
          fontFamily: kFontFamily,
        ),
      ),
    );
  }
}

/*class AndroidTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    animation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.easeInToLinear,
    );
    return SlideTransition(
      transformHitTests: false,
      position: animation.drive(
        Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ),
      ),
      child: child,
    );
  }
}*/
