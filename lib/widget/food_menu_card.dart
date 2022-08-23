import 'package:erp_pos/constant/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constant/theme.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

class FoodMenuCard extends StatefulWidget {
  String image;
  String title;
  int amount;

  FoodMenuCard(
      {required this.image, required this.title, required this.amount});

  @override
  State<FoodMenuCard> createState() => _FoodMenuCardState();
}

class _FoodMenuCardState extends State<FoodMenuCard> {
  int number = 0;
  ERPFoodSize erpFoodSize = ERPFoodSize.Small;

  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        number += 1;
      });
    } else {
      if (number > 0) {
        setState(() {
          number -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, custom_route.Route.foodMenuDetail);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
              decoration: BoxDecoration(
                  color: Color(0xFFF4F5F6),
                  borderRadius: BorderRadius.circular(7.r)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.image,
                    width: 65.w,
                    height: 65.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: ERPTheme.BASE_COLOR),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text.rich(TextSpan(
                            text: 'ລາຄາ ',
                            style: TextStyle(
                                fontSize: 14.sp, color: ERPTheme.BASE_COLOR),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(widget.amount)} kip',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                        Row(
                          children: [
                            Text('ຈຳນວນ',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ERPTheme.BASE_COLOR)),
                            SizedBox(
                              width: 10.w,
                            ),
                            buildButton(Icons.add, () {
                              setNumber(true);
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  Text(
                                    number < 10 ? '0$number' : '$number',
                                    style: TextStyle(
                                        color: ERPTheme.BASE_COLOR,
                                        fontSize: 14.sp),
                                  ),
                                  Container(
                                    width: 20.w,
                                    height: 2.h,
                                    decoration:
                                        BoxDecoration(color: Color(0xFFD9D9D9)),
                                  )
                                ],
                              ),
                            ),
                            buildButton(Icons.minimize, () {
                              setNumber(false);
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ERPTheme.BASE_COLOR, shape: BoxShape.circle),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_shopping_cart_sharp,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildSize('S', ERPFoodSize.Small),
              SizedBox(
                width: 7.w,
              ),
              buildSize('M', ERPFoodSize.Medium),
              SizedBox(
                width: 7.w,
              ),
              buildSize('L', ERPFoodSize.Large),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildSize(String title, ERPFoodSize size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          erpFoodSize = size;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: erpFoodSize == size ? ERPTheme.BASE_COLOR : Colors.white,
            border: Border.all(
                color: erpFoodSize == size
                    ? ERPTheme.BASE_COLOR
                    : Color(0xFFD9D9D9))),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: erpFoodSize == size ? Colors.white : Color(0xFFD9D9D9)),
        ),
      ),
    );
  }

  Container buildButton(IconData iconData, VoidCallback onPressed) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: ERPTheme.BASE_COLOR),
            shape: BoxShape.circle),
        child: IconButton(onPressed: onPressed, icon: Icon(iconData)));
  }
}
