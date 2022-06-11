import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  Utils._();

  /// TODO: Uncomment the below given line for discount offers
  // static final List<DiscountModel> _kDiscounts = [];

  /// method to unfocus keyboard if keyboard is visible or input has focus
  static void unFocus(BuildContext context) {
    final focusNode = FocusScope.of(context);
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  /// method to request next focus if has
  static bool nextFocus(BuildContext context) {
    final focusNode = FocusScope.of(context);
    if (focusNode.canRequestFocus) {
      return focusNode.nextFocus();
    }
    return false;
  }

  /// method to remove html tags from given data
  static String removeHtmlTags(String data) {
    RegExp regExp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return data
        .replaceAll('<li>', '\n\t\u2022 ')
        .replaceAll("&nbsp;", " ")
        .replaceAll("&amp;", "&")
        .replaceAll("&quot;", "\"")
        .replaceAll("&#39;", "'")
        .replaceAll("&rsquo;", "'")
        .replaceAll("&lt;", "<")
        .replaceAll("&gt;", ">")
        .replaceAll("<br />", "\n")
        .replaceAll(regExp, "");
  }

  /// Method to show toast message
  static Future<bool?> showToast(String msg) {
    return Fluttertoast.showToast(msg: msg);
  }
}
