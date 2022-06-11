import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget widget;

  CustomPageRoute({required this.widget, RouteSettings? settings})
      : super(settings: settings);

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
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
      child: widget,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}
