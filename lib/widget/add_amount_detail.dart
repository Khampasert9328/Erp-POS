import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AddAmountDetait extends StatefulWidget {
  String? title;
  AddAmountDetait({this.title});

  @override
  State<AddAmountDetait> createState() => _AddAmountDetaitState();
}

class _AddAmountDetaitState extends State<AddAmountDetait> {
  int count = 0;

  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        count ++;
      });
    } else {
      if (count > 0) {
        setState(() {
          count --;
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
        GestureDetector(
          onTap: () async {
            setNumber(true);
          },
          child: buildButton(Icons.add, "+"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      count < 10 ? '0$count' : '$count',
                      style: TextStyle(
                          color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                    ),
                    Container(
                      width: 20.w,
                      height: 2.h,
                      decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setNumber(
              false,
            );
            context.read<FoodMenuProvider>().remove(count);
          },
          child: buildButton(Icons.add, "-"),
        ),
      ],
    );
  }

  Container buildButton(IconData iconData, String title) {
    return Container(
      height: 30.h,
      width: 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.BASE_COLOR),
          shape: BoxShape.circle),
      child: Center(child: Text(title)),
    );
  }
}
