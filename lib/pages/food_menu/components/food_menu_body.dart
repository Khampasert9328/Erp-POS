import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodMenuBody extends StatelessWidget {
  TextEditingController searchMenu = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                'ລາຍການອາຫານ',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ERPTextfield(controller: searchMenu, hintText: 'ຄົ້ນຫາອາຫານ')),
                  SizedBox(width: 15.w,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.search, size: 45,))
                ],
              ),
            ],
          ),
        )),
        Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'ລາຍການອາຫານ',
                      style: TextStyle(
                          fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text.rich(TextSpan(
                        style: TextStyle(
                            fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
                        text: 'ລວມລາຄາ: ',
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' 70.000 ກີບ',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ERPTheme.BASE_COLOR,
                                fontWeight: FontWeight.bold),
                          )
                        ]))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 55,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
