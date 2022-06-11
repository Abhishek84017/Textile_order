import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textile/utils/palette.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    Key? key,
    this.label,
    this.labelStyle,
    this.items,
    this.value,
    this.padding,
    this.margin,
    this.onChanged,
    this.style,
    this.hint,
  }) : super(key: key);

  final String? label;
  final TextStyle? labelStyle;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ValueChanged<T?>? onChanged;
  final double itemHeight = 50;
  final TextStyle? style;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final _margin =
        EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h).copyWith(
      left: margin?.horizontal,
      right: margin?.horizontal,
      bottom: margin?.vertical,
      top: margin?.vertical,
    );
    Widget child = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w).copyWith(
        left: padding?.horizontal,
        right: padding?.horizontal,
        bottom: padding?.vertical,
        top: padding?.vertical,
      ),
      margin: label == null || label!.isEmpty ? _margin : null,
      width: 1.sw,
      height: 42.0.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.inputBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          style: TextStyle(
            fontSize: 12.0.sp,
            decoration: TextDecoration.none,
            color: Palette.blackColor,
            height: 1.35,
          ).merge(style),
          onChanged: onChanged,
          value: value,
          isExpanded: true,
          items: items,
          itemHeight: itemHeight,
          hint: hint != null && hint!.isNotEmpty ? Text(hint!) : null,
        ),
      ),
    );

    if (label != null && label!.isNotEmpty) {
      child = Padding(
        padding: _margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label!,
              style: TextStyle(
                fontSize: 10.0.sp,
                fontWeight: FontWeight.w500,
                color: Palette.inputHintColor,
              ).merge(labelStyle),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            child
          ],
        ),
      );
    }

    return child;
  }
}
