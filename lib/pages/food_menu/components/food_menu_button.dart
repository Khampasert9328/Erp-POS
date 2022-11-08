import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodMenuButton extends StatelessWidget {
  String title;
  FoodMenuButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.BASE_COLOR),
          shape: BoxShape.circle),
      child: Center(child: Text(title)),
    );
  }
}
