import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FoodMenuSize extends StatelessWidget {
  String title;
  int size;
  int index;
  int mainsize;
  VoidCallback onPressed;

  FoodMenuSize({
    required this.size,
    required this.title,
    required this.index,
    required this.mainsize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetFoodMenuProvider>(builder: (context, model, _) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: mainsize == size ? AppTheme.YELLOW_COLOR : Colors.white,
              border: Border.all(
                  color: mainsize == size
                      ? AppTheme.YELLOW_COLOR
                      : Color(0xFFD9D9D9))),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: mainsize == size ? Colors.white : Color(0xFFD9D9D9)),
          ),
        ),
      );
    });
  }
}
