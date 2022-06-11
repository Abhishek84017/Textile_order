import 'package:flutter/material.dart';

/// Mixin to add post frame callback on [StatefulWidget]
///

mixin PostFrameCallBack<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(postFrameCallback);
  }

  /// Post frame callback method
  void postFrameCallback(Duration timeStamp);
}
