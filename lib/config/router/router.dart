import 'dart:async';
import 'package:textile/app.dart';

import 'page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navigate {
  Navigate._();

  /// Push screen
  static Future<T?> to<T>(Widget widget, {RouteSettings? settings}) {
    return MyApp.materialNavKey.currentState!
        .push<T>(CustomPageRoute(widget: widget, settings: settings));
  }

  /// Replace screen
  static Future replace<T, TO>(Widget widget, {RouteSettings? settings}) {
    return MyApp.materialNavKey.currentState!.pushReplacement<T, TO>(
        CustomPageRoute(widget: widget, settings: settings));
  }

  /// Remove all and push
  static Future toAndRemoveAll<T, TO>(Widget widget,
      {RouteSettings? settings}) {
    return MyApp.materialNavKey.currentState!.pushAndRemoveUntil(
        CustomPageRoute(widget: widget, settings: settings), (route) => false);
  }

  /// close current screen
  /// if can not close the application
  static Future<void> close<T>([T? result]) async {
    if (MyApp.materialNavKey.currentState!.canPop()) {
      return MyApp.materialNavKey.currentState!.pop<T>(result);
    }
    return await SystemNavigator.pop();
  }

  /// if may close then closes the screen
  static void mayClose<T>([T? result]) async {
    await MyApp.materialNavKey.currentState!.maybePop<T>(result);
  }
}
