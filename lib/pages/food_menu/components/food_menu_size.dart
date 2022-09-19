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

  FoodMenuSize({required this.size, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetFoodMenuProvider>(builder: (context, model, _) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: model.getlistProduct[index].size == size ? AppTheme.BASE_COLOR : Colors.white,
              border: Border.all(
                  color:
                  model.getlistProduct[index].size == size ? AppTheme.BASE_COLOR : Color(0xFFD9D9D9))),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: model.getlistProduct[index].size == size ? Colors.white : Color(0xFFD9D9D9)),
          ),
        ),
      );
    });
  }
}
