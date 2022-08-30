import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAmount extends StatefulWidget {
  String? title;
  int? number;
  AddAmount({this.title,required this.number});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  int count = 0;
 
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
        Text(widget.title ?? 'ຈຳນວນ',
            style: TextStyle(fontSize: 14.sp, color: ERPTheme.BASE_COLOR)),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () async{

           setNumber(true);

           SharedPreferences preferences = await SharedPreferences.getInstance();
           preferences.setString(CountPre().namkey, count.toString());
           
          },
          child: buildButton(Icons.add, "+"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                count < 10 ? '0$count' : '$count',
                style: TextStyle(color: ERPTheme.BASE_COLOR, fontSize: 14.sp),
              ),
              Container(
                width: 20.w,
                height: 2.h,
                decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
              )
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setNumber(false,);
            },
            child: buildButton(Icons.add, "-"),
          ),
        ),
      ],
    );
  }

  Container buildButton(IconData iconData, String title) {
    return Container(
      height: 30.h,
      width: 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: ERPTheme.BASE_COLOR),
          shape: BoxShape.circle),
      child: Center(child: Text(title)),
    );
  }
}
