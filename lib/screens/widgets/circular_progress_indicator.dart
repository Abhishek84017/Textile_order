import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key, this.size, this.color = Colors.white})
      : super(key: key);
  final double? size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double _size = size ?? 22.0.r;
    return Center(
      child: SizedBox(
        height: _size,
        width: _size,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
