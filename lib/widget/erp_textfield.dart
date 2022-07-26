import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ERPTextfield extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  int? maxlines;

  ERPTextfield({required this.controller, required this.hintText, this.maxlines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines ?? 1,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.r),
          borderSide: BorderSide(
            color: Color(0xFF696877),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.r),
          borderSide: BorderSide(
            color: Color(0xFF696877),
          ),
        ),
      ),
      controller: controller,
    );
  }
}
