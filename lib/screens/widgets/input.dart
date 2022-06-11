import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textile/utils/palette.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.keyBoardType
  }) : super(key: key);
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextFormField(
        keyboardType: keyBoardType,
        controller: controller,
        style: TextStyle(
          height: 1.5,
          fontSize: 13.sp,
        ),
        cursorHeight: 16.sp,
        obscureText: obscureText,
        readOnly: readOnly,
        decoration: InputDecoration(

          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            height: 1.5,
          ),
          labelStyle: const TextStyle(
            color: Palette.inputHintColor,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
