import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_button.dart';
import 'package:erp_pos/pages/food_menu/models/food_menu_data_model.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
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
  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        count ++;
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
          width: 20.w,
        ),
        GestureDetector(
          onTap: () async {
            
            setNumber(false);
            context.read<FoodMenuProvider>().remove(count);
            if (count<1) {
               context.read<GetFoodMenuProvider>().addtochartbutton(widget.index, false);
            }
          },
          child: FoodMenuButton(
            title: '-',
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
        GestureDetector(
          onTap: () async {
            print("conut:$count");
           
            setNumber(true);
            context.read<FoodMenuProvider>().increment(count);
             if (count >0) {
            context.read<GetFoodMenuProvider>().addtochartbutton(widget.index, true);
            }
          },
          child: FoodMenuButton(
            title: '+',
          ),
        ),
      ],
    );
  }
}
