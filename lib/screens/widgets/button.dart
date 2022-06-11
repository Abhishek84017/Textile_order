import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';
import 'package:textile/utils/palette.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.label,
      this.onPressed,
      this.margin,
      this.width,
      this.height,
      this.isInAsync = false})
      : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool isInAsync;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.h),
        boxShadow: const [
          BoxShadow(
            color: Palette.shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      height: height ?? 50.h,
      width: width ?? 0.6.sw,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Palette.buttonBackgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.h),
            ),
          ),
        ),
        child: isInAsync
            ? const AppProgressIndicator()
            : Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
      ),
    );
  }
}
