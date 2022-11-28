import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_button.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AddAmount extends StatefulWidget {
  String? title;
  int index;
  AddAmount({this.title, required this.index});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  int count = 0;
  bool show = false;
  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        count += 1;
      });
    } else {
      if (count > 0) {
        setState(() {
          count -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title ?? 'ຈຳນວນ',
          style: TextStyle(
            fontFamily: 'Phetsarath-OT',
            fontSize: 14.sp,
            color: AppTheme.BASE_COLOR,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              setNumber(false);
              context.read<FoodMenuProvider>().remove(count);
              CountPre().setamount(count);
            },
            child: FoodMenuButton(
              title: '-',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                count < 10 ? '0$count' : '$count',
                style: TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
              ),
              Container(
                width: 20.w,
                height: 3.h,
                decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
              )
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              setNumber(true);
              context.read<FoodMenuProvider>().increment(count);
              CountPre().setCount(count);
            },
            child: FoodMenuButton(
              title: '+',
            ),
          ),
        ),
      ],
    );
  }
}
